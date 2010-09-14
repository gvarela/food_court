require 'food_court/packages/update_chef'

policy :update_chef, :roles => :bootstrap do
  requires :update_chef
end

deployment do
  delivery :capistrano do
    begin
      recipes 'config/chef/bootstrap'
    rescue LoadError
      puts 'Please provide a config/chef/bootstrap.rb file in your working directory'
    end
    debug = true if ENV['DEBUG'] == 'true'
  end
  source do
    prefix '/usr/local'
    archives '/usr/local/src'
    builds '/usr/local/src'
  end
end
