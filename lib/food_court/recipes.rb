#
# You need to add
#  require 'chauffeur/recipes'
# to your deploy.rb
#
#
make_notify_task = lambda do

  namespace :food_court do

    # run food_court chef-solo on the remote server
    desc "setup chef-solo on the remote server"
    task :setup, :only => {:food_court => true } do
      # TODO detect package manager to use
#      run "uname -a" do |channel, stream, data|
#        if data =~ /Ubuntu/
#
#        end
#      end
#      sudo "curl http://apt.opscode.com/packages@opscode.com.gpg.key | apt-key add -"
      sudo "apt-get -y update"
      sudo "apt-get install -y rubygems ohai chef"
      sudo "/etc/init.d/chef-client stop"
    end

    desc "deploy your food_court chef-solo cookbooks"
    task :deploy, :only => {:food_court => true } do

    end
  end
  
end
require 'capistrano/version'
if Capistrano::Version::MAJOR < 2
  STDERR.puts "Unable to load #{__FILE__}\nFood Court Capistrano hooks require at least version 2.0.0"
else
  instance = Capistrano::Configuration.instance
  if instance
    instance.load &make_notify_task
  else
    make_notify_task.call
  end
end