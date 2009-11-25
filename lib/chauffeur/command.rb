require 'fileutils'
module Chauffeur
  class Command
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
      FileUtils.cp File.join(TEMPLATE_PATH, template, 'dna.rb'), File.join(path, 'config/chef', 'dna.rb')
      FileUtils.cp File.join(TEMPLATE_PATH, template, 'solo.rb'), File.join(path, 'config/chef', 'solo.rb')
    end

    def help

    end

    def config()
      
    end

  end
end