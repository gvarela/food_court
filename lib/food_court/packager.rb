require 'fileutils'
require 'json'

module FoodCourt
  class Packager
    attr_reader :config, :current_path

    def initialize(path=nil)
      @current_path = path || Dir.pwd
    end

    def compile()
      time = Time.now

      deployment_dir = File.join(current_path, 'config/chef/deployments',  time.strftime('%Y-%m-%d-%H-%M-%S'))
      FileUtils.mkdir_p deployment_dir

      dna = config[:dna]
      File.open(deployment_dir + "/dna.json", "w"){ |f| f.write(dna.to_json) }

      File.open(deployment_dir + "/solo.rb", "w") do |file|
        file.write <<-EOH
file_cache_path '#{config[:file_cache_path]}'
cookbook_path   ['#{cookbook_paths.join("', '")}']
log_level :#{config[:log_level] || 'info'}
        EOH
      end
      FileUtils.cp_r File.join(current_path, 'config/chef/site-cookbooks'), File.join(deployment_dir, 'site-cookbooks')
      `cd #{deployment_dir} && tar czvf site-cookbooks.tar.gz site-cookbooks`
      return deployment_dir
    end

    def cookbook_remote_locations
       config[:cookbooks].map{ |book, path| path }
    end

    def cookbook_paths
      cache_path = config[:file_cache_path]
      books = []
      config[:cookbooks].each{ |book, path| books << "#{cache_path}/#{book}"}
      books << "#{cache_path}/site-cookbooks"
      books
    end

    def configure()
      order_path = File.join(current_path, 'config/chef', 'order.rb')
      raise "no order.rb found in path [#{order_path}]" unless File.exists?(order_path)
      config_file = File.read(order_path)
      @config ||= eval "#{config_file}"
    end
  end
end
