require 'fileutils'

module FoodCourt
  class Command
    attr_reader :current_path
    TEMPLATE_PATH = File.join( File.dirname(__FILE__), '/../../', 'templates' )

    def initialize(*args)
      @current_path = ENV['PATH'] || Dir.pwd
      command = args.shift
      if self.respond_to? command.to_sym
        self.send command, *args
      else
        self.help
      end
    end

    def setup(template='nginx-passenger-ree')
      FileUtils.mkdir_p File.join current_path, 'config/chef'
      FileUtils.mkdir_p File.join current_path, 'config/chef/deployments'
      FileUtils.cp File.join(TEMPLATE_PATH, template, 'order.rb'), File.join(current_path, 'config/chef', 'order.rb')
      FileUtils.cp_r File.join(TEMPLATE_PATH, template, 'site-cookbooks'), File.join(current_path, 'config/chef/site-cookbooks')
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
      sh "mkdir -p #{File.join(dir, name, "templates", "default")}"
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