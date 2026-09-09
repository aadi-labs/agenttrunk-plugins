# frozen_string_literal: true
# Maintained metadata restored by postprocessing.
def add_custom_gemspec_data(spec)
  spec.authors = ['Aadi Labs']
  spec.homepage = 'https://github.com/aadi-labs/agenttrunk-plugins'
  spec.license = 'MIT'
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['documentation_uri'] = spec.homepage + '/tree/main/sdk/ruby'
  # Include newly generated files even when the checkout also has tracked files.
  spec.files = Dir.chdir(__dir__) { Dir.glob('lib/**/*').select { |f| File.file?(f) } + %w[README.md LICENSE reference.md] }
end
