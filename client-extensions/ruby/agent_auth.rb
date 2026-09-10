# frozen_string_literal: true
require 'json'
require 'uri'
require 'net/http'

module AgentTrunk
  class AgentAuthError < StandardError; end
  # No credential persistence or automatic retries. Humans approve externally.
  class AgentRegistration
    attr_reader :resource, :issuer, :guide
    def self.origin(value)
      u = URI.parse(value)
      raise AgentAuthError, 'invalid_origin' unless u.is_a?(URI::HTTPS) && u.host && !u.userinfo && ['', '/'].include?(u.path) && !u.query && !u.fragment
      u.path = ''; u.to_s
    rescue URI::InvalidURIError, TypeError
      raise AgentAuthError, 'invalid_origin'
    end
    def self.endpoint(value, issuer)
      u = URI.parse(value)
      base = u.dup; base.path = ''; base.query = nil; base.fragment = nil
      raise AgentAuthError, 'untrusted_endpoint' unless base.to_s == issuer && !u.userinfo && !u.fragment
      value
    rescue URI::InvalidURIError, TypeError
      raise AgentAuthError, 'invalid_discovery'
    end
    def self.secret(value)
      raise AgentAuthError, 'invalid_credentials' unless value.is_a?(String) && !value.empty? && value.bytesize <= 32768 && !value.match?(/\s/)
      value
    end
    def self.request(url, body=nil, form: false)
      u = URI.parse(url)
      req = body.nil? ? Net::HTTP::Get.new(u) : Net::HTTP::Post.new(u)
      if body
        req['Content-Type'] = form ? 'application/x-www-form-urlencoded' : 'application/json'
        req.body = form ? URI.encode_www_form(body) : JSON.generate(body)
      end
      bytes = +''
      http = Net::HTTP.new(u.host, u.port, nil)
      http.use_ssl = true; http.open_timeout = 15; http.read_timeout = 15; http.write_timeout = 15; http.max_retries = 0
      http.start do |connection|
        connection.request(req) do |response|
          raise AgentAuthError, "request_rejected:#{response.code}" unless response.code.to_i.between?(200,299)
          response.read_body do |chunk|
            bytes << chunk
            raise AgentAuthError, 'response_too_large' if bytes.bytesize > 131072
          end
        end
      end
      result = JSON.parse(bytes)
      raise AgentAuthError, 'invalid_response' unless result.is_a?(Hash)
      result
    rescue AgentAuthError
      raise
    rescue StandardError
      raise AgentAuthError, 'network_or_response_failure', cause: nil
    end
    def self.discover(resource='https://api.agenttrunk.ai')
      api = origin(resource); meta = request(api+'/.well-known/oauth-protected-resource')
      servers = meta['authorization_servers']
      raise AgentAuthError, 'invalid_discovery' unless meta['resource'] == api && servers.is_a?(Array) && servers.length == 1
      issuer = origin(servers[0]); server = request(issuer+'/.well-known/oauth-authorization-server')
      raise AgentAuthError, 'registration_unavailable' unless server['issuer'] == issuer && server.dig('agent_auth','identity_types_supported')&.include?('service_auth')
      new(api,issuer,server)
    end
    def initialize(resource,issuer,server)
      @resource, @issuer = resource, issuer
      auth = server.fetch('agent_auth')
      @guide = self.class.endpoint(auth['skill'],issuer)
      @identity_endpoint = self.class.endpoint(auth['identity_endpoint'],issuer)
      @claim_endpoint = self.class.endpoint(auth['claim_endpoint'],issuer)
      @token_endpoint = self.class.endpoint(server['token_endpoint'],issuer)
    end
    def start(email)
      raise AgentAuthError, 'invalid_email' unless email.is_a?(String) && email.bytesize <= 254 && email.match?(/\A[^\s@]+@[^\s@]+\.[^\s@]+\z/)
      result = self.class.request(@identity_endpoint,{'type'=>'service_auth','login_hint'=>email})
      claim = result.fetch('claim'); token = self.class.secret(claim['token'])
      attempt = claim['attempt'] || self.class.request(@claim_endpoint,{'type'=>'service_auth','login_hint'=>email,'claim_token'=>token})['attempt']
      {'claim_token'=>token,'verification_uri'=>self.class.endpoint(attempt['verification_uri'],@issuer)}
    end
    def complete(claim_token,user_code)
      raise AgentAuthError, 'invalid_user_code' unless user_code.is_a?(String) && user_code.match?(/\A[A-Za-z0-9-]{4,32}\z/)
      identity(self.class.request(@claim_endpoint+'/complete',{'claim_token'=>self.class.secret(claim_token),'user_code'=>user_code})['identity'])
    end
    def exchange(value)
      result = self.class.request(@token_endpoint,{'grant_type'=>'urn:ietf:params:oauth:grant-type:jwt-bearer','assertion'=>self.class.secret(value['assertion']),'resource'=>@resource},form:true)
      ttl = result['expires_in']
      raise AgentAuthError, 'invalid_credentials' unless result['token_type'].to_s.downcase == 'bearer' && ttl.is_a?(Numeric) && ttl.finite? && ttl > 0
      {'access_token'=>self.class.secret(result['access_token']),'expires_in'=>ttl}
    end
    def refresh(value)
      identity(self.class.request(@identity_endpoint,{'type'=>'refresh','refresh_token'=>self.class.secret(value.dig('refresh_token','value'))})['identity'])
    end
    private
    def identity(value)
      result = {'assertion'=>self.class.secret(value&.fetch('assertion',nil))}
      result['refresh_token'] = {'value'=>self.class.secret(value.dig('refresh_token','value'))} if value['refresh_token']
      result
    end
  end
end
