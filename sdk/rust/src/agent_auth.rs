//! Human-approved agent registration; caller owns secret storage and refresh scheduling.
use reqwest::{Client, Url};
use serde_json::{json, Value};
use std::time::Duration;

pub struct AgentRegistration { pub resource: String, pub issuer: String, pub guide: String, identity: String, claim: String, token: String, http: Client }
fn origin(s: &str) -> Result<String,String> {
    let u=Url::parse(s).map_err(|_|"invalid_origin")?;
    if u.scheme()!="https" || u.host_str().is_none() || !u.username().is_empty() || u.password().is_some() || u.path()!="/" || u.query().is_some() || u.fragment().is_some(){return Err("invalid_origin".into())}
    Ok(u.origin().ascii_serialization())
}
fn endpoint(v: &Value, issuer: &str)->Result<String,String>{let s=v.as_str().ok_or("invalid_discovery")?;let u=Url::parse(s).map_err(|_|"invalid_endpoint")?;if u.origin().ascii_serialization()!=issuer || !u.username().is_empty() || u.password().is_some() || u.fragment().is_some(){return Err("untrusted_endpoint".into())}Ok(s.into())}
fn secret(v:&Value)->Result<&str,String>{let s=v.as_str().ok_or("invalid_credentials")?;if s.is_empty()||s.len()>32768||s.chars().any(char::is_whitespace){return Err("invalid_credentials".into())}Ok(s)}
fn identity(v:&Value)->Result<Value,String>{let mut result=json!({"assertion":secret(&v["assertion"])?});if !v["refresh_token"].is_null(){result["refresh_token"]=json!({"value":secret(&v["refresh_token"]["value"])?});}Ok(result)}
impl AgentRegistration {
    async fn request(http:&Client,url:&str,body:Option<Value>,form:bool)->Result<Value,String>{
        let builder=if let Some(v)=body {if form {http.post(url).form(&v)}else{http.post(url).json(&v)}}else{http.get(url)};
        let mut response=builder.send().await.map_err(|_|"authentication_network_failure")?;
        if !response.status().is_success(){return Err(format!("request_rejected:{}",response.status().as_u16()))}
        let mut bytes=Vec::new();while let Some(chunk)=response.chunk().await.map_err(|_|"invalid_response")?{if bytes.len()+chunk.len()>131072{return Err("response_too_large".into())}bytes.extend_from_slice(&chunk);}
        let v:Value=serde_json::from_slice(&bytes).map_err(|_|"invalid_response")?;if !v.is_object(){return Err("invalid_response".into())}Ok(v)
    }
    pub async fn discover(resource:&str)->Result<Self,String>{
        let api=origin(resource)?;let http=Client::builder().redirect(reqwest::redirect::Policy::none()).timeout(Duration::from_secs(15)).build().map_err(|_|"client_unavailable")?;
        let meta=Self::request(&http,&format!("{api}/.well-known/oauth-protected-resource"),None,false).await?;
        let servers=meta["authorization_servers"].as_array().ok_or("invalid_discovery")?;
        if meta["resource"].as_str()!=Some(&api)||servers.len()!=1{return Err("invalid_discovery".into())}
        let issuer=origin(servers[0].as_str().ok_or("invalid_issuer")?)?;
        let server=Self::request(&http,&format!("{issuer}/.well-known/oauth-authorization-server"),None,false).await?;
        if server["issuer"].as_str()!=Some(&issuer)||!server["agent_auth"]["identity_types_supported"].as_array().ok_or("registration_unavailable")?.iter().any(|v|v=="service_auth"){return Err("registration_unavailable".into())}
        let a=&server["agent_auth"];Ok(Self{resource:api,guide:endpoint(&a["skill"],&issuer)?,identity:endpoint(&a["identity_endpoint"],&issuer)?,claim:endpoint(&a["claim_endpoint"],&issuer)?,token:endpoint(&server["token_endpoint"],&issuer)?,issuer,http})
    }
    pub async fn start(&self,email:&str)->Result<Value,String>{
        let parts:Vec<_>=email.split('@').collect();if email.len()>254||email.chars().any(char::is_whitespace)||parts.len()!=2||parts[0].is_empty()||!parts[1].contains('.') {return Err("invalid_email".into())}
        let r=Self::request(&self.http,&self.identity,Some(json!({"type":"service_auth","login_hint":email})),false).await?;let token=secret(&r["claim"]["token"])?;
        let attempt=if r["claim"]["attempt"].is_null(){Self::request(&self.http,&self.claim,Some(json!({"type":"service_auth","login_hint":email,"claim_token":token})),false).await?["attempt"].clone()}else{r["claim"]["attempt"].clone()};
        Ok(json!({"claim_token":token,"verification_uri":endpoint(&attempt["verification_uri"],&self.issuer)?}))
    }
    pub async fn complete(&self,claim_token:&str,code:&str)->Result<Value,String>{
        if !(4..=32).contains(&code.len())||!code.bytes().all(|b|b.is_ascii_alphanumeric()||b==b'-'){return Err("invalid_user_code".into())}
        let claim=json!(claim_token);secret(&claim)?;
        let result=Self::request(&self.http,&format!("{}/complete",self.claim),Some(json!({"claim_token":claim_token,"user_code":code})),false).await?;identity(&result["identity"])
    }
    pub async fn exchange(&self,value:&Value)->Result<Value,String>{
        let result=Self::request(&self.http,&self.token,Some(json!({"grant_type":"urn:ietf:params:oauth:grant-type:jwt-bearer","assertion":secret(&value["assertion"])?,"resource":self.resource})),true).await?;
        let ttl=result["expires_in"].as_f64().ok_or("invalid_credentials")?;if ttl<=0.0||!ttl.is_finite()||!result["token_type"].as_str().unwrap_or("").eq_ignore_ascii_case("bearer"){return Err("invalid_credentials".into())}
        Ok(json!({"access_token":secret(&result["access_token"])?,"expires_in":ttl}))
    }
    pub async fn refresh(&self,value:&Value)->Result<Value,String>{let result=Self::request(&self.http,&self.identity,Some(json!({"type":"refresh","refresh_token":secret(&value["refresh_token"]["value"])?})),false).await?;identity(&result["identity"])}
}

#[cfg(test)] mod tests {use super::*;#[test] fn validates_authority_and_credentials(){assert!(origin("http://api.example.com").is_err());assert!(endpoint(&json!("https://other.example/claim"),"https://auth.example.com").is_err());assert!(secret(&json!("a b")).is_err());assert_eq!(identity(&json!({"assertion":"a","refresh_token":{"value":"b"}})).unwrap()["assertion"],"a");}}
