use agenttrunk::prelude::*;
#[tokio::main]
async fn main() {
    let result: Result<(), Box<dyn std::error::Error>> = async {
        let client=AgentTrunk::new(ClientConfig{token:Some(std::env::var("AGENTTRUNK_ACCESS_TOKEN")?),base_url:std::env::var("AGENTTRUNK_API_URL").unwrap_or_else(|_|"https://api.agenttrunk.ai".into()),..Default::default()})?;
        let page=client.workspaces.list(&Default::default(),None).await?;
        println!("{}",serde_json::to_string(&page)?);Ok(())
    }.await;
    if result.is_err(){eprintln!("Read failed. Check runtime authorization and connectivity.");std::process::exit(1);}
}
