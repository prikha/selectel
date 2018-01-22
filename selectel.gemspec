
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "selectel/version"

Gem::Specification.new do |spec|
  spec.name          = "selectel"
  spec.version       = Selectel::VERSION
  spec.authors       = ["Serj Prikhodko"]
  spec.email         = ["prikha@gmail.com"]

  spec.summary       = %q{Selectel API Wrapper}
  spec.description   = %q{Allows you to manage your virtual resources dynamically via API}
  spec.homepage      = "https://github.com/prikha/selectel"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "http", "~>3.0.0"
  spec.add_runtime_dependency "json", "~>2.1.0"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
