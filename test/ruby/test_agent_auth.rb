require 'minitest/autorun'
require_relative '../../client-extensions/ruby/agent_auth'
class AgentAuthTest < Minitest::Test
  def test_authorities_and_secrets
    assert_raises(AgentTrunk::AgentAuthError) {AgentTrunk::AgentRegistration.origin('http://api.example.com')}
    assert_raises(AgentTrunk::AgentAuthError) {AgentTrunk::AgentRegistration.endpoint('https://other.example/token','https://auth.example.com')}
    assert_raises(AgentTrunk::AgentAuthError) {AgentTrunk::AgentRegistration.secret('a b')}
  end
  def test_complete_exchange_and_refresh
    klass=Class.new(AgentTrunk::AgentRegistration) do
      def self.request(url,body=nil,form:false)
        if url.end_with?('/token')
          raise 'not form encoded' unless form
          {'access_token'=>'access','expires_in'=>300,'token_type'=>'Bearer'}
        else
          {'identity'=>{'assertion'=>'identity','refresh_token'=>{'value'=>'refresh'}}}
        end
      end
    end
    issuer='https://auth.example.com'
    auth=klass.new('https://api.example.com',issuer,{'token_endpoint'=>issuer+'/token','agent_auth'=>{'skill'=>issuer+'/guide','identity_endpoint'=>issuer+'/identity','claim_endpoint'=>issuer+'/claim'}})
    id=auth.complete('claim','ABCD-EFGH')
    assert_equal 'access',auth.exchange(id)['access_token']
    assert_equal 'refresh',auth.refresh(id)['refresh_token']['value']
  end
end
