require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "food_court"
    gem.summary = %Q{Bootstrap and provision your ubuntu slice with ease}
    gem.description = %Q{Bootstrap and provision your ubuntu slice with ease}
    gem.email = "gvarela@gmail.com"
    gem.homepage = "http://github.com/gvarela/food_court"
    gem.authors = ["Gabe Varela"]
    gem.add_dependency('json', '~> 1.4.6')
    gem.add_dependency('activesupport', '~> 2.3.9')
    gem.add_dependency('highline', '~> 1.4.0')
    gem.add_dependency('capistrano', '~> 2.5.5')
    gem.add_dependency('sprinkle', '~> 0.3.1')
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "yard", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
 spec.libs << 'lib' << 'spec'
 spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
 spec.libs << 'lib' << 'spec'
 spec.pattern = 'spec/**/*_spec.rb'
 spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec
#
#begin
#  require 'yard'
#  YARD::Rake::YardocTask.new
#rescue LoadError
#  task :yardoc do
#    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
#  end
#end
