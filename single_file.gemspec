# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'single_file/version'

Gem::Specification.new do |spec|
  spec.name          = "single_file"
  spec.version       = SingleFile::VERSION
  spec.authors       = ["Ben Govero"]
  spec.email         = ["ben.govero@cph.org"]

  spec.summary       = %q{Run a block of code only if a system level file lock can be obtained for a given filepath.}
  spec.homepage      = "http://github.com/cph/single_file"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "shoulda-context"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "pry"
end
