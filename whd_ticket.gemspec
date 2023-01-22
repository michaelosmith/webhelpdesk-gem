# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'whd_ticket/version'

Gem::Specification.new do |spec|
  spec.name          = "whd_ticket"
  spec.version       = WhdTicket::VERSION
  spec.authors       = ["Michael Smith"]
  spec.email         = ["smith.michael.oliver@gmail.com"]

  spec.summary       = %q{Command line to create a new ticket in WebHelpDesk (WHD)}
  spec.description   = %q{This gem exposes a command line that creates a new ticket in WebHelpDesk through its API.\n It is quite specific to a scenario I am working on, bit I might make it more general down the line.}
  spec.homepage      = "https://bitbucket.org/michaelosmith"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables   << 'whd_ticket'
  spec.require_paths = ["lib"]
  
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
