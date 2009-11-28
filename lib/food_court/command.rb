require 'fileutils'
require 'json'

module FoodCourt
  class Command
    attr_reader :config, :current_path
    TEMPLATE_PATH = File.join( File.dirname(__FILE__), '/../../', 'templates' )

    def initialize(*args)
      @current_path = Dir.pwd
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

    end

    def package()
      deployment_dir = File.join(current_path, 'config/chef/deployments/',  Time.now.strftime('%Y-%m-%d-%H-%M-%S'))
      FileUtils.mkdir_p deployment_dir
      dna = config[:dna]
      open(deployment_dir + "/dna.json", "w").write(dna.to_json)

      cache_path = config[:file_cache_path]
      cookbook_paths = cookbooks.map{ |book| "#{cache_path}/#{book}"}
      open(deployment_dir + "/solo.rb", "w") do |file|
        file.puts <<-EOH
file_cache_path '#{cache_path}'
cookbook_path   [#{cookbook_paths}]
        EOH
        FileUtils.cp_r File.join(current_path, 'config/chef/site-cookbooks'), File.join(deployment_dir, 'site-cookbooks')
      end
    end

    def fetch_remote_cookbooks()
      config[:cookbooks]
    end

    def cookbooks
      ['site-cookbooks', 'cookbooks']
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

    def configure()
      order_path = File.join(current_path, 'config/chef', 'order.rb')
      raise "no order.rb found in path [#{order_path}]" unless File.exists?(order_path)
      config_file = File.read(order_path)
      eval "@config ||= #{config_file}"
    end

  end
end