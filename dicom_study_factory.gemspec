# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dicom_study_factory/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 2.6.1'
  spec.name          = 'dicom_study_factory'
  spec.version       = DicomStudyFactory::VERSION
  spec.authors       = ['Diego Lagos']
  spec.email         = ['diego@myorb.com']

  spec.summary       = 'Create a dicom files samples filling tags with a factory library'
  spec.description   = 'We need dicom files populated with the right tags to test and use it for DEMOs.
  Unfortunately the anonymize process delete all the main tags required to test.
  For this reason this gem is relevant to create a sample collection.'
  spec.homepage      = 'https://github.com/diegopiccinini/dicom_study_factory/README.md'
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = 'rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/diegopiccinini/dicom_study_factory'
  spec.metadata['changelog_uri'] = 'https://github.com/diegopiccinini/dicom_study_factory/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'byebug', '~> 11.1'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'guard-rubocop', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.89'
end
