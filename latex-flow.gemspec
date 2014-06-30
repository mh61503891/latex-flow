# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'latex-flow/version'

Gem::Specification.new do |spec|
  spec.name          = "latex-flow"
  spec.version       = LatexFlow::VERSION
  spec.authors       = ["Masayuki Higashino"]
  spec.email         = ["mh.on.web@gmail.com"]
  spec.summary       = %q{Latex-flow is a command-line tool to support LaTeX's workflow.}
  spec.description   = %q{Latex-flow is a command-line tool to support LaTeX's workflow.}
  spec.homepage      = "https://github.com/mh61503891/latex-flow"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "systemu"
  spec.add_dependency "watchr"
  spec.add_dependency "highline"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
