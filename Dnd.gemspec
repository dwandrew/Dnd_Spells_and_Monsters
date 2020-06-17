require_relative 'lib/Dnd/version'

Gem::Specification.new do |spec|
  spec.name          = "DnD Spells and Monsters"
  spec.version       = Dnd::VERSION
  spec.authors       = ["dwandrew"]
  spec.email         = ["danwandrew@gmail.com"]

  spec.summary       = %q{"A tool for accessing the Data of the 5th Edition Dungeons and Dragons Spells and Monsters"}
  spec.homepage      = "https://github.com/dwandrew/Dnd.git"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

if spec.respond_to?(:metadata)
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/dwandrew/Dnd_Spells_and_Monsters.git"
  spec.metadata["changelog_uri"] = "https://github.com/dwandrew/Dnd_Spells_and_Monsters.git"
else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "pry"
  spec.add_dependency "json"
  spec.add_dependency gem 'colorize', '~> 0.8.1'
  spec.add_dependency gem 'net/http'
end
