# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "exp"
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Roland Shoemaker"]
  s.date = "2011-09-26"
  s.email = "rolandshoemaker@gmail.com"
  s.files = ["lib/exp.rb"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "nowarning"
  s.rubygems_version = "1.8.23"
  s.summary = "Ruby Psych experiment"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<highline>, [">= 0"])
    else
      s.add_dependency(%q<highline>, [">= 0"])
    end
  else
    s.add_dependency(%q<highline>, [">= 0"])
  end
end

