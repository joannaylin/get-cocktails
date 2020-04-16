# -*- encoding: utf-8 -*-
# stub: tty 0.7.0 ruby lib

Gem::Specification.new do |s|
  s.name = "tty".freeze
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Murach".freeze]
  s.date = "2017-03-26"
  s.description = "A toolbox for developing beautiful command line clients.".freeze
  s.email = ["".freeze]
  s.homepage = "https://piotrmurach.github.io/tty/".freeze
  s.rubygems_version = "3.1.2".freeze
  s.summary = "A toolbox for developing beautiful command line clients. It provides a fluid interface for gathering input from the user, querying system and terminal and displaying information back.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<tty-color>.freeze, ["~> 0.4.0"])
    s.add_runtime_dependency(%q<tty-cursor>.freeze, ["~> 0.4.0"])
    s.add_runtime_dependency(%q<tty-command>.freeze, ["~> 0.4.0"])
    s.add_runtime_dependency(%q<tty-editor>.freeze, ["~> 0.2.0"])
    s.add_runtime_dependency(%q<tty-file>.freeze, ["~> 0.3.0"])
    s.add_runtime_dependency(%q<tty-pager>.freeze, ["~> 0.7.0"])
    s.add_runtime_dependency(%q<tty-platform>.freeze, ["~> 0.1.0"])
    s.add_runtime_dependency(%q<tty-progressbar>.freeze, ["~> 0.10.0"])
    s.add_runtime_dependency(%q<tty-prompt>.freeze, ["~> 0.12.0"])
    s.add_runtime_dependency(%q<tty-screen>.freeze, ["~> 0.5.0"])
    s.add_runtime_dependency(%q<tty-spinner>.freeze, ["~> 0.4.0"])
    s.add_runtime_dependency(%q<tty-table>.freeze, ["~> 0.8.0"])
    s.add_runtime_dependency(%q<tty-which>.freeze, ["~> 0.3.0"])
    s.add_runtime_dependency(%q<equatable>.freeze, ["~> 0.5.0"])
    s.add_runtime_dependency(%q<pastel>.freeze, ["~> 0.7.0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.5.0", "< 2.0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  else
    s.add_dependency(%q<tty-color>.freeze, ["~> 0.4.0"])
    s.add_dependency(%q<tty-cursor>.freeze, ["~> 0.4.0"])
    s.add_dependency(%q<tty-command>.freeze, ["~> 0.4.0"])
    s.add_dependency(%q<tty-editor>.freeze, ["~> 0.2.0"])
    s.add_dependency(%q<tty-file>.freeze, ["~> 0.3.0"])
    s.add_dependency(%q<tty-pager>.freeze, ["~> 0.7.0"])
    s.add_dependency(%q<tty-platform>.freeze, ["~> 0.1.0"])
    s.add_dependency(%q<tty-progressbar>.freeze, ["~> 0.10.0"])
    s.add_dependency(%q<tty-prompt>.freeze, ["~> 0.12.0"])
    s.add_dependency(%q<tty-screen>.freeze, ["~> 0.5.0"])
    s.add_dependency(%q<tty-spinner>.freeze, ["~> 0.4.0"])
    s.add_dependency(%q<tty-table>.freeze, ["~> 0.8.0"])
    s.add_dependency(%q<tty-which>.freeze, ["~> 0.3.0"])
    s.add_dependency(%q<equatable>.freeze, ["~> 0.5.0"])
    s.add_dependency(%q<pastel>.freeze, ["~> 0.7.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.5.0", "< 2.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
