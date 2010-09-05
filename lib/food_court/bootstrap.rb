require 'food_court/packages/base'
require 'food_court/packages/build_essential'
require 'food_court/packages/ruby'
require 'food_court/packages/rubygems'
require 'food_court/packages/chef_solo'

policy :chef_solo, :roles => :bootstrap do
  requires :chef_solo
end

deployment do
  delivery :capistrano do
    begin
      recipes 'config/chef/bootstrap'
    rescue LoadError
      puts 'Please provide a config/bootstrap.rb file in your working directory'
    end
    debug = true if ENV['DEBUG'] == 'true'
  end
  source do
    prefix '/usr/local'
    archives '/usr/local/src'
    builds '/usr/local/src'
  end
end