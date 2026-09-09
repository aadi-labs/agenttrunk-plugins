require 'minitest/autorun'
require 'socket'
require 'AgentTrunk'
class AgentTrunkSafetyTest < Minitest::Test
  def serve(status, body)
    server=TCPServer.new('127.0.0.1',0)
    calls=0
    thread=Thread.new do
      loop do
        socket=server.accept; calls+=1
        request_line=socket.gets
        while (line=socket.gets) && line!="\r\n"; end
        payload=body.respond_to?(:call) ? body.call(request_line) : body
        socket.write("HTTP/1.1 #{status} Test\r\nContent-Length: #{payload.bytesize}\r\nLocation: /redirected\r\nConnection: close\r\n\r\n#{payload}")
        socket.close
      end
    rescue IOError, Errno::EBADF
    end
    yield "http://127.0.0.1:#{server.addr[1]}", -> {calls}
  ensure
    thread&.kill; server&.close
  end
  def test_mutations_and_redirects_never_retry
    [401,403,409,429,503,302].each do |status|
      serve(status,'SENSITIVE') do |url,calls|
        client=AgentTrunk::Client.new(base_url:url,token:'test',max_retries:3)
        error=assert_raises(AgentTrunk::Errors::ResponseError){client.workspaces.create(name:'test')}
        refute_includes error.to_s,'SENSITIVE';assert_equal 1,calls.call
      end
    end
  end
  def test_untyped_json_and_binary_survive_generation
    serve(200,'{"data":[]}') do |url,_|
      assert_equal({'data'=>[]},AgentTrunk::Client.new(base_url:url,token:'test').context_sets.list)
    end
    serve(200,'hello') do |url,_|
      c=AgentTrunk::Client.new(base_url:url,token:'test')
      assert_equal 'hello',c.contexts.read_file(trunk_id:'w',context_key:'k',resource_path:'SKILL.md',ref:'a'*64)
    end
  end
  def test_pin_and_limit
    c=AgentTrunk::Client.new(token:'test')
    assert_raises(ArgumentError){c.contexts.read_file(trunk_id:'w',context_key:'k',resource_path:'SKILL.md',ref:'latest')}
    serve(200,'x'*1_000_001) do |url,_|
      c=AgentTrunk::Client.new(base_url:url,token:'test')
      assert_raises(ArgumentError){c.contexts.read_file(trunk_id:'w',context_key:'k',resource_path:'SKILL.md',ref:'a'*64)}
    end
  end
  def test_verified_read_rejects_tampering
    [false,true].each do |tamper|
      manifest=File.read(File.join(__dir__,'manifest.json'))
      payload=->(request){request.include?('/files/') ? (tamper ? 'tampered' : 'verified') : manifest}
      serve(200,payload) do |url,_|
        client=AgentTrunk::Client.new(base_url:url,token:'test')
        action=-> {AgentTrunk::Verified.read_file(client,workspace:'w',key:'k',revision:'a'*64,path:'SKILL.md')}
        if tamper then assert_raises(ArgumentError,&action) else assert_equal 'verified',action.call end
      end
    end
  end

end
