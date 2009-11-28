require 'fileutils'
module FoodCourt
  class Command
    attr_reader :config
    TEMPLATE_PATH = File.join File.dirname(__FILE__), '/../../', 'templates'

    def initialize(*args)
      command = args.shift
      if self.respond_to? command.to_sym
        self.send command, *args
      else
        self.help
      end
    end

    def setup(path, template='slicehost')
      path = File.expand_path(path)
      FileUtils.mkdir_p File.join path, 'config/chef'
      FileUtils.mkdir_p File.join path, 'config/chef/site-cookbooks'
      FileUtils.mkdir_p File.join path, 'config/chef/deployments'
      FileUtils.cp File.join(TEMPLATE_PATH, template, 'order.rb'), File.join(path, 'config/chef', 'order.rb')
    end

    def help

    end

    def package()

    end

    def fetch_remote_cookbooks()

    end

    def create_cookbook(dir, name)
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

    def configure(dir)
      order_path = File.join(path, 'config/chef', 'order.rb')
      raise "no order.rb found in path [#{order_path}]" unless File.exists?(order_path)
      config_file = File.read(order_path)
      eval "@config ||= #{config_file}"
    end

  end
end