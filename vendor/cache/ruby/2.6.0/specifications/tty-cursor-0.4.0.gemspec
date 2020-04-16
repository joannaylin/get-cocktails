# -*- encoding: utf-8 -*-
# stub: tty-cursor 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "tty-cursor".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Murach".freeze]
  s.date = "2017-01-08"
  s.description = "The purpose of this library is to help move the terminal cursor around and manipulate text by using intuitive method calls.".freeze
  s.email = ["".freeze]
  s.homepage = "http://piotrmurach.github.io/tty/".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Terminal cursor positioning, visibility and text manipulation.".freeze

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
