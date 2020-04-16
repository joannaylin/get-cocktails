# -*- encoding: utf-8 -*-
# stub: tty-editor 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "tty-editor".freeze
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Murach".freeze]
  s.bindir = "exe".freeze
  s.date = "2017-03-26"
  s.description = "Opens a file or text in the user's preferred editor.".freeze
  s.email = ["".freeze]
  s.homepage = "https://piotrmurach.github.io/tty".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Opens a file or text in the user's preferred editor.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<tty-prompt>.freeze, ["~> 0.12.0"])
    s.add_runtime_dependency(%q<tty-which>.freeze, ["~> 0.3.0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.5.0", "< 2.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
  else
    s.add_dependency(%q<tty-prompt>.freeze, ["~> 0.12.0"])
    s.add_dependency(%q<tty-which>.freeze, ["~> 0.3.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.5.0", "< 2.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
  end
end
