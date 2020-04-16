# -*- encoding: utf-8 -*-
# stub: tty-platform 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "tty-platform".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Murach".freeze]
  s.date = "2015-05-16"
  s.description = "Query methods for detecting different operating systems.".freeze
  s.email = ["".freeze]
  s.homepage = "".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Query methods for detecting different operating systems.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.6"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
  end
end
