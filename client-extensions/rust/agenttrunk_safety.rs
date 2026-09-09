use agenttrunk::prelude::*;
use std::sync::{Arc,atomic::{AtomicUsize,Ordering}};
use tokio::io::{AsyncReadExt,AsyncWriteExt};
async fn server(status:u16,body:String)->(String,Arc<AtomicUsize>,tokio::task::JoinHandle<()>){
 let listener=tokio::net::TcpListener::bind("127.0.0.1:0").await.unwrap();let url=format!("http://{}",listener.local_addr().unwrap());let calls=Arc::new(AtomicUsize::new(0));let count=calls.clone();
 let task=tokio::spawn(async move{loop{let(mut socket,_)=listener.accept().await.unwrap();count.fetch_add(1,Ordering::SeqCst);let mut b=[0;8192];let n=socket.read(&mut b).await.unwrap_or(0);let payload=if body=="VERIFY" || body=="TAMPER" {if String::from_utf8_lossy(&b[..n]).contains("/files/"){if body=="TAMPER"{"tampered"}else{"verified"}}else{include_str!("manifest.json")}}else{&body};let response=format!("HTTP/1.1 {status} Test\r\nLocation: /redirected\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{payload}",payload.len());let _=socket.write_all(response.as_bytes()).await;}});(url,calls,task)
}
#[tokio::test]
async fn mutations_and_redirects_never_retry(){
 for status in [401,403,409,429,503,302]{let(url,calls,task)=server(status,"SENSITIVE".into()).await;let c=AgentTrunk::new(ClientConfig{base_url:url,token:Some("test".into()),max_retries:3,..Default::default()}).unwrap();
 let result=c.workspaces.create(&CreateTrunkInput{name:"test".into(),..Default::default()},None).await;assert!(result.is_err());assert!(!format!("{}",result.unwrap_err()).contains("SENSITIVE"));assert_eq!(calls.load(Ordering::SeqCst),1);task.abort();}
}
#[tokio::test]
async fn immutable_reads_are_bounded(){
 let(url,calls,task)=server(200,"x".repeat(1_000_001)).await;let c=AgentTrunk::new(ClientConfig{base_url:url,token:Some("test".into()),..Default::default()}).unwrap();
 assert!(c.contexts.read_file("w","k","SKILL.md",&ReadFileQueryRequest{r#ref:"latest".into()},None).await.is_err());assert_eq!(calls.load(Ordering::SeqCst),0);
 let result=c.contexts.read_file("w","k","SKILL.md",&ReadFileQueryRequest{r#ref:"a".repeat(64)},None).await.unwrap().collect().await;assert!(result.is_err());task.abort();
}

#[tokio::test]
async fn verified_read_rejects_tampering(){
 for tamper in [false,true]{let(url,_,task)=server(200,if tamper{"TAMPER"}else{"VERIFY"}.into()).await;let c=AgentTrunk::new(ClientConfig{base_url:url,token:Some("test".into()),..Default::default()}).unwrap();
 let result=agenttrunk::verified::read_file(&c,"w","k",&"a".repeat(64),"SKILL.md").await;if tamper{assert!(result.is_err());}else{assert_eq!(result.unwrap(),b"verified");}task.abort();}
}
#[test]
fn path_parameters_are_encoded(){assert_eq!(agenttrunk::safety::path_param("a/b?c").unwrap(),"a%2Fb%3Fc");assert!(agenttrunk::safety::path_param("..").is_err());}
