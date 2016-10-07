lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ecco/version"

Gem::Specification.new do |spec|
  spec.name          = "ecco"
  spec.version       = Ecco::VERSION
  spec.authors       = ["Twingly AB"]
  spec.email         = ["support@twingly.com"]

  spec.summary       = %q{MySQL replication binlog parser.}
  spec.description   = %q{MySQL replication binlog parser using mysql-binlog-connector-java.}
  spec.homepage      = "https://github.com/twingly/ecco"
  spec.license       = "Apache-2.0"

  spec.platform      = "java"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sequel"
  spec.add_development_dependency "jdbc-mysql"
end
