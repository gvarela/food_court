require 'json'

module FoodCourt
  class Packager
    attr_reader :config, :current_path

    def initialize(path=nil)
      @current_path = path || Dir.pwd
    end

    def compile()
      time = Time.now
      deployment_dir = File.join(current_path, 'config/chef/deployments',  time.strftime('%Y-%m-%d') + "-#{time}")
      FileUtils.mkdir_p deployment_dir
      dna = config[:dna]
      File.open(deployment_dir + "/dna.json", "w"){ |f| f.write(dna.to_json) }

      cache_path = config[:file_cache_path]
      cookbook_paths = cookbooks.map{ |book| "#{cache_path}/#{book}"}
      File.open(deployment_dir + "/solo.rb", "w") do |file|
        file.write <<-EOH
file_cache_path '#{cache_path}'
cookbook_path   [#{cookbook_paths}]
        EOH
        FileUtils.cp_r File.join(current_path, 'config/chef/site-cookbooks'), File.join(deployment_dir, 'site-cookbooks')
      end
      return deployment_dir
    end

    def fetch_remote_cookbooks()
      config[:cookbooks]
    end

    def cookbooks
      ['site-cookbooks', 'cookbooks']
    end

    def configure()
      order_path = File.join(current_path, 'config/chef', 'order.rb')
      raise "no order.rb found in path [#{order_path}]" unless File.exists?(order_path)
      config_file = File.read(order_path)
      eval "@config ||= #{config_file}"
    end
  end
end