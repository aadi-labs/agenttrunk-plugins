use crate::prelude::*;
use sha2::{Digest, Sha256};
fn digest(s: &str) -> bool { s.len()==64 && s.bytes().all(|b| b.is_ascii_digit() || (b'a'..=b'f').contains(&b)) }
pub async fn read_file(client: &AgentTrunk, workspace: &str, key: &str, revision: &str, path: &str) -> Result<Vec<u8>, ApiError> {
    if !digest(revision) || path.is_empty() || path.len()>512 || path.chars().any(|c| c=='\\' || c.is_control()) || path.split('/').any(|s|s.is_empty()||s=="."||s=="..") {return Err(ApiError::InvalidHeader);}
    let pin=client.contexts.inspect(workspace,key,&InspectQueryRequest{r#ref:Some(revision.into())},None).await?;
    if pin.revision.id!=revision {return Err(ApiError::InvalidHeader);}
    let file=pin.revision.files.iter().find(|f|f.path==path).ok_or(ApiError::InvalidHeader)?;
    if file.size<0 || file.size>1_000_000 || !digest(&file.sha256){return Err(ApiError::InvalidHeader);}
    let data=client.contexts.read_file(workspace,key,path,&ReadFileQueryRequest{r#ref:revision.into()},None).await?.collect().await?;
    if data.len() as i64 != file.size || format!("{:x}",Sha256::digest(&data))!=file.sha256 {return Err(ApiError::InvalidHeader);}
    Ok(data)
}
