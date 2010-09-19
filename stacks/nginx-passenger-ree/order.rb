application = "my-application.com"
user = :deploy

{
  :file_cache_path => "/var/chef",
  :log_level => :info,
  :cookbooks => { 'cookbooks' => 'http://github.com/gvarela/food_court_cookbooks/tarball/master' },

  :dna => {
    :users =>  {
      user =>  {
 # openssl passwd -l
        :password => "password-hash",
        :comment =>  "Deploy User"
      }
    },

    :ssh_keys => {
      user => "ssh-rsa ... ==email@example.com"
    },

    :authorization => {
      :sudo => {
        :users => [ user ]
      }
    },

    :mysql => {
      :server_root_password => "root-password",
      :bind_address => "127.0.0.1"
    },

    :ruby_enterprise => {
      :version => "1.8.7-2010.01",
      :install_path => "/usr/local",
      :ruby_bin => "/usr/local/bin/ruby",
      :gems_dir => "/usr/local/lib/ruby/gems/1.8",
      :url => "http://rubyforge.org/frs/download.php/71096/ruby-enterprise-1.8.7-2010.01"
    },

    :passenger_enterprise => {
      :version => "2.2.15",
      :root_path => "/usr/local/lib/ruby/gems/1.8/gems/passenger-2.2.15"
    },

    :gems => [
      {:name => 'bundler'}
    ],

    # :pkgs => [
      # {:name => 'wget'}
    # ],

    :apps => [
      {
        :name => "my-application",
        :username => user,
        :git_branch => "master",
        :server =>  "my-application.local",
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

