require_relative '../lib/AgentTrunk'
begin
  client = AgentTrunk::Client.new(token: ENV.fetch('AGENTTRUNK_ACCESS_TOKEN'), base_url: ENV.fetch('AGENTTRUNK_API_URL','https://api.agenttrunk.ai'))
  page = client.workspaces.list
  puts JSON.generate(page.to_h)
rescue StandardError
  warn 'Read failed. Check runtime authorization and connectivity.'
  exit 1
end
