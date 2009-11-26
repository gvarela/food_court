#
# You need to add
#  require 'chauffeur/recipes'
# to your deploy.rb
#
#
make_notify_task = lambda do

  namespace :food_court do

    # run chauffeur chef-solo on the remote server
    desc "setup"
    task :setup, :only => {:chauffeur => true } do
      
    end

    desc "deploy your chauffeur chef-solo cookbooks"
    task :deploy, :only => {:chauffeur => true } do

    end
  end
  
end
require 'capistrano/version'
if Capistrano::Version::MAJOR < 2
  STDERR.puts "Unable to load #{__FILE__}\nChauffeur Capistrano hooks require at least version 2.0.0"
else
  instance = Capistrano::Configuration.instance
  if instance
    instance.load &make_notify_task
  else
    make_notify_task.call
  end
end