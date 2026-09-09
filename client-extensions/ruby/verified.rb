require 'digest'
module AgentTrunk
  module Verified
    def self.read_file(client, workspace:, key:, revision:, path:)
      valid_path = path.bytesize.between?(1,512) && !path.match?(/[\\\x00-\x1f\x7f]/) && path.split('/',-1).none? { |s| ['', '.', '..'].include?(s) }
      raise ArgumentError, 'Immutable revision and relative path required' unless revision.match?(/\A[a-f0-9]{64}\z/) && valid_path
      inspected = client.contexts.inspect(trunk_id: workspace, context_key: key, ref: revision)
      raise ArgumentError, 'Revision mismatch' unless inspected.revision.id == revision
      file = inspected.revision.files.find { |f| f.path == path }
      raise ArgumentError, 'Invalid manifest' unless file && file.size.between?(0,1_000_000) && file.sha256.match?(/\A[a-f0-9]{64}\z/)
      bytes = client.contexts.read_file(trunk_id: workspace, context_key: key, resource_path: path, ref: revision)
      raise ArgumentError, 'Integrity check failed' unless bytes.bytesize == file.size && Digest::SHA256.hexdigest(bytes) == file.sha256
      bytes
    end
  end
end
