# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{food_court}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gabe Varela"]
  s.date = %q{2011-05-09}
  s.default_executable = %q{food-court}
  s.description = %q{Bootstrap and provision your ubuntu slice with ease}
  s.email = %q{gvarela@gmail.com}
  s.executables = ["food-court"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/food-court",
    "food_court.gemspec",
    "lib/food_court.rb",
    "lib/food_court/bootstrap.rb",
    "lib/food_court/command.rb",
    "lib/food_court/packager.rb",
    "lib/food_court/packages/base.rb",
    "lib/food_court/packages/build_essential.rb",
    "lib/food_court/packages/chef_solo.rb",
    "lib/food_court/packages/ruby.rb",
    "lib/food_court/packages/rubygems.rb",
    "lib/food_court/packages/update_chef.rb",
    "lib/food_court/recipes.rb",
    "lib/food_court/update_slice.rb",
    "spec/command_spec.rb",
    "spec/fixtures/order.rb",
    "spec/packager_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "stacks/nginx-passenger-ree/bootstrap.rb",
    "stacks/nginx-passenger-ree/order.rb"
  ]
  s.homepage = %q{http://github.com/gvarela/food_court}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.0}
  s.summary = %q{Bootstrap and provision your ubuntu slice with ease}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["= 1.2.9"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<json>, ["~> 1.4.6"])
      s.add_development_dependency(%q<activesupport>, ["~> 2.3.9"])
      s.add_development_dependency(%q<highline>, ["~> 1.4.0"])
      s.add_development_dependency(%q<capistrano>, ["~> 2.5.5"])
      s.add_development_dependency(%q<sprinkle>, ["~> 0.3.1"])
      s.add_development_dependency(%q<fakefs>, [">= 0"])
      s.add_runtime_dependency(%q<json>, ["~> 1.4.6"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 2.3.9"])
      s.add_runtime_dependency(%q<highline>, ["~> 1.4.0"])
      s.add_runtime_dependency(%q<capistrano>, ["~> 2.5.5"])
      s.add_runtime_dependency(%q<sprinkle>, ["~> 0.3.1"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["= 1.2.9"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<json>, ["~> 1.4.6"])
      s.add_dependency(%q<activesupport>, ["~> 2.3.9"])
      s.add_dependency(%q<highline>, ["~> 1.4.0"])
      s.add_dependency(%q<capistrano>, ["~> 2.5.5"])
      s.add_dependency(%q<sprinkle>, ["~> 0.3.1"])
      s.add_dependency(%q<fakefs>, [">= 0"])
      s.add_dependency(%q<json>, ["~> 1.4.6"])
      s.add_dependency(%q<activesupport>, ["~> 2.3.9"])
      s.add_dependency(%q<highline>, ["~> 1.4.0"])
      s.add_dependency(%q<capistrano>, ["~> 2.5.5"])
      s.add_dependency(%q<sprinkle>, ["~> 0.3.1"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["= 1.2.9"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<json>, ["~> 1.4.6"])
    s.add_dependency(%q<activesupport>, ["~> 2.3.9"])
    s.add_dependency(%q<highline>, ["~> 1.4.0"])
    s.add_dependency(%q<capistrano>, ["~> 2.5.5"])
    s.add_dependency(%q<sprinkle>, ["~> 0.3.1"])
    s.add_dependency(%q<fakefs>, [">= 0"])
    s.add_dependency(%q<json>, ["~> 1.4.6"])
    s.add_dependency(%q<activesupport>, ["~> 2.3.9"])
    s.add_dependency(%q<highline>, ["~> 1.4.0"])
    s.add_dependency(%q<capistrano>, ["~> 2.5.5"])
    s.add_dependency(%q<sprinkle>, ["~> 0.3.1"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end

