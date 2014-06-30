# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qiita_matome/version'

Gem::Specification.new do |spec|
  spec.name          = 'qiita_matome'
  spec.version       = QiitaMatome::VERSION
  spec.authors       = ['tbpgr']
  spec.email         = ['tbpgr@tbpgr.jp']
  spec.summary       = %q(Qiita article matome generator)
  spec.description   = %q(Qiita article matome generator)
  spec.homepage      = 'https://github.com/tbpgr/qiita_matome'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '>= 4.0.1'
  spec.add_runtime_dependency 'activemodel', '>= 4.0.2'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.add_development_dependency 'simplecov', '~> 0.8.2'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
end
