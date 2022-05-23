# -*- encoding: utf-8 -*-
# stub: middleman 3.3.4 ruby lib

Gem::Specification.new do |s|
  s.name = "middleman".freeze
  s.version = "3.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Thomas Reynolds".freeze, "Ben Hollis".freeze, "Karl Freeman".freeze]
  s.date = "2022-03-30"
  s.description = "A static site generator. Provides dozens of templating languages (Haml, Sass, Compass, Slim, CoffeeScript, and more). Makes minification, compression, cache busting, Yaml data (and more) an easy part of your development cycle.".freeze
  s.email = ["me@tdreyno.com".freeze, "ben@benhollis.net".freeze, "karlfreeman@gmail.com".freeze]
  s.files = [".gemtest".freeze, "Rakefile".freeze, "features/.gitkeep".freeze, "fixtures/.gitkeep".freeze, "lib/middleman.rb".freeze, "middleman.gemspec".freeze, "spec/middleman/future_spec.rb".freeze, "spec/spec_helper.rb".freeze]
  s.homepage = "http://middlemanapp.com".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Hand-crafted frontend development".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<middleman-core>.freeze, ["= 3.3.4"])
    s.add_runtime_dependency(%q<middleman-sprockets>.freeze, [">= 3.1.2"])
    s.add_runtime_dependency(%q<haml>.freeze, [">= 4.0.5"])
    s.add_runtime_dependency(%q<sass>.freeze, [">= 3.2.17", "< 4.0"])
    s.add_runtime_dependency(%q<compass-import-once>.freeze, ["= 1.0.5"])
    s.add_runtime_dependency(%q<compass>.freeze, [">= 0.12.4"])
    s.add_runtime_dependency(%q<uglifier>.freeze, ["~> 2.5"])
    s.add_runtime_dependency(%q<coffee-script>.freeze, ["~> 2.2"])
    s.add_runtime_dependency(%q<execjs>.freeze, ["~> 2.0"])
    s.add_runtime_dependency(%q<kramdown>.freeze, ["~> 1.2"])
  else
    s.add_dependency(%q<middleman-core>.freeze, ["= 3.3.4"])
    s.add_dependency(%q<middleman-sprockets>.freeze, [">= 3.1.2"])
    s.add_dependency(%q<haml>.freeze, [">= 4.0.5"])
    s.add_dependency(%q<sass>.freeze, [">= 3.2.17", "< 4.0"])
    s.add_dependency(%q<compass-import-once>.freeze, ["= 1.0.5"])
    s.add_dependency(%q<compass>.freeze, [">= 0.12.4"])
    s.add_dependency(%q<uglifier>.freeze, ["~> 2.5"])
    s.add_dependency(%q<coffee-script>.freeze, ["~> 2.2"])
    s.add_dependency(%q<execjs>.freeze, ["~> 2.0"])
    s.add_dependency(%q<kramdown>.freeze, ["~> 1.2"])
  end
end
