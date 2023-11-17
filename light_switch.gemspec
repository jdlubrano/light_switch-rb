require_relative "lib/light_switch/version"

Gem::Specification.new do |spec|
  spec.name = "light_switch"
  spec.version = LightSwitch::VERSION
  spec.authors = ["Joel Lubrano"]
  spec.email = ["joel.lubrano@gmail.com"]
  spec.homepage = "https://github.com/jdlubrano/light_switch_rb"
  spec.summary = "Circuit breakers on Rails"
  spec.description = "An implementation of the circuit breaker pattern using ActiveRecord"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jdlubrano/light_switch_rb"
  spec.metadata["changelog_uri"] = "https://github.com/jdlubrano/light_switch_rb/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "LICENSE.txt", "Rakefile", "README.md"]
  end

  spec.add_dependency "inline_svg", "~> 1.9"
  spec.add_dependency "rails", ">= 7.0.2.2", "< 7.2"
  spec.add_dependency "turbo-rails", "~> 1.5"

  spec.add_development_dependency "standard"
end
