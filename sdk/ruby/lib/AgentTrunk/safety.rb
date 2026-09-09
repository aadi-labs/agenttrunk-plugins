# frozen_string_literal: true
module AgentTrunk
  module Safety
    def self.validate!(url, headers)
      raise ArgumentError, 'HTTPS origin required' unless url.scheme == 'https' || (url.scheme == 'http' && %w[localhost 127.0.0.1 [::1]].include?(url.host))
      raise ArgumentError, 'URL credentials forbidden' if url.userinfo || url.fragment
      if url.path.start_with?('/v1/')
        token = headers.find { |key, _| key.to_s.downcase == 'authorization' }&.last
        raise ArgumentError, 'Runtime bearer token required' unless token.to_s.match?(/\ABearer \S+\z/)
      end
      if url.path.include?('/files/')
        refs = URI.decode_www_form(url.query || '').select { |key, _| key == 'ref' }
        raise ArgumentError, 'Immutable ref required' unless refs.length == 1 && refs[0][1].match?(/\A[a-f0-9]{64}\z/)
      end
    end
    def self.request(conn, request, url)
      limit = url.path.include?('/files/') ? 1_000_000 : 24_000_000
      conn.request(request) do |response|
        unless (200..299).cover?(response.code.to_i)
          raise AgentTrunk::Errors::ResponseError.new('AgentTrunk request failed', code: response.code.to_i)
        end
        data = ''.b
        response.read_body do |chunk|
          raise ArgumentError, 'Response exceeds size limit' if data.bytesize + chunk.bytesize > limit
          data << chunk
        end
        response.body = data
      end
    end
  end
end
