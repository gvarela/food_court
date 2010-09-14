require 'fileutils'
require 'sprinkle'

module FoodCourt
  class Command
    attr_reader :current_path
    TEMPLATE_PATH = File.join( File.dirname(__FILE__), '/../../', 'stacks' )

    def initialize(*args)
      @current_path = Dir.pwd
      command = args.shift
      if self.respond_to? command.to_sym
        self.send command, *args
      else
        self.help
      end
    end

    def init(template='nginx-passenger-ree')
      puts "Setting up current directory for #{template} stack"
      FileUtils.mkdir_p File.join(current_path, 'config/chef')
      FileUtils.mkdir_p File.join(current_path, 'config/chef/deployments')
      FileUtils.cp File.join(TEMPLATE_PATH, template, 'order.rb'), File.join(current_path, 'config/chef', 'order.rb')
      FileUtils.cp File.join(TEMPLATE_PATH, template, 'bootstrap.rb'), File.join(current_path, 'config/chef', 'bootstrap.rb')
      FileUtils.cp_r File.join(TEMPLATE_PATH, template, 'site-cookbooks'), File.join(current_path, 'config/chef/site-cookbooks')
    end

    def bootstrap( bootstrap_file = nil )
      # Provide your own sprinkle config or use the default one to bootstrap your slice.
      bootstrap_file ||= File.join(File.dirname(__FILE__), 'bootstrap.rb')
      # Sprinkle::OPTIONS[:force] = true
      raise 'a bootstrap.rb file is required for bootstrapping, please run "food_court init"' unless File.exists?( 'config/chef/bootstrap.rb' )
      Sprinkle::OPTIONS[:verbose] = true
      # Sprinkle::OPTIONS[:test] = true
      Sprinkle::Script.sprinkle( File.read( bootstrap_file ) )
    end

    def update( update_config = nil )
      # Provide your own sprinkle config or use the default one to update_slice your slice.
      update_config ||= File.join(File.dirname(__FILE__), 'update_slice.rb')
      # Sprinkle::OPTIONS[:force] = true
      raise 'a update_slice.rb file is required for updating the chef configuration on your slice, please run "food_court update"' unless File.exists?( 'config/chef/bootstrap.rb' )
      Sprinkle::OPTIONS[:verbose] = true
      # Sprinkle::OPTIONS[:test] = true
      Sprinkle::Script.sprinkle( File.read( update_config ) )
    end


    def help
      puts File.read('../../README.rdoc')
    end

    def create_cookbook(name, dir=current_path)
      raise "Must provide a name" unless name
      puts "** Creating cookbook #{name}"
      sh "mkdir -p #{File.join(dir, name, "attributes")}"
      sh "mkdir -p #{File.join(dir, name, "recipes")}"
      sh "mkdir -p #{File.join(dir, name, "definitions")}"
      sh "mkdir -p #{File.join(dir, name, "libraries")}"
      sh "mkdir -p #{File.join(dir, name, "files", "default")}"
      sh "mkdir -p #{File.join(dir, name, "stacks", "default")}"
      unless File.exists?(File.join(dir, name, "recipes", "default.rb"))
        open(File.join(dir, name, "recipes", "default.rb"), "w") do |file|
          file.puts <<-EOH
#
# Cookbook Name:: #{name}
# Recipe:: default
#
# Copyright #{Time.now.year}, MY_COMPANY
#
          EOH
        end
      end
    end

  end
end
