# your application name
application = "my-application"
# domain of your site
domain = "my-application.com"
# user you want to create for deployments
user = :deploy
# password for the use needs to be a hash use openssl to generate
# openssl passwd -1
user_password_hash = "..."
# your public ssh key
user_ssh_key = "ssh-rsa ... ==email@example.com"
#your mysql root user password
mysql_root_password = "..."

# To deploy you must add a new remote origin to your local git repo
#   git remote add production deploy@xx.xx.xx.xx:~/repos/my-application.git
# Then to deploy your code changes
#   git push production master
# See: http://akitaonrails.com/2010/02/20/cooking-solo-with-chef for info

# Assumes you are using bundler and that your code is on the master branch
# If you understand how chef works feel free to update the code below

{
  :file_cache_path => "/var/chef",
  :log_level => :info,
  :cookbooks => { 'cookbooks' => 'http://github.com/gvarela/food_court_cookbooks/tarball/master' },

  :dna => {
    :users =>  {
      user =>  {
        :password => user_password_hash,
        :comment =>  "Deploy User"
      }
    },

    :ssh_keys => {
      user => user_ssh_key
    },

    :authorization => {
      :sudo => {
        :users => [ user ]
      }
    },

    :mysql => {
      :server_root_password => mysql_root_password,
      :bind_address => "127.0.0.1"
    },

    :ruby_enterprise => {
      :version => "1.8.7-2010.01",
      :install_path => "/usr/local",
      :ruby_bin => "/usr/local/bin/ruby",
      :gems_dir => "/usr/local/lib/ruby/gems/1.8",
      :url => "http://rubyforge.org/frs/download.php/68719/ruby-enterprise-1.8.7-2010.01"
    },

    :passenger_enterprise => {
      :version => "2.2.15",
      :root_path => "/usr/local/lib/ruby/gems/1.8/gems/passenger-2.2.15"
    },

    :gems => [
      {:name => 'bundler'}
    ],

    :pkgs => [
      # {:name => 'wget'}
    ],

    :apps => [
      {
        :name => application,
        :username => user,
        :git_branch => "master",
        :server =>  domain,
        :pre_migration =>  "bundle install"
      }
    ],

    :recipes => [
      "build-essential",
      "git",
      "iptables",
      "users",
      "sudo",
      # "imagemagick",
      "passenger_enterprise::nginx",
      "pkgs",
      "gems",
      "mysql::server",
      "simple_rails_app"

    ]
  }
}

