application = "application_name.com"
user = :deploy

{
  :file_cache_path => "/var/chef",
  :cookbooks => { 'cookbooks' => 'http://github.com/gvarela/food_court_cookbooks/tarball/master' },

  :dna => {
    :users =>  {
      user =>  {
  # openssl -l
        :password => "password_hash",
        :comment =>  "Deploy User"
      }
    },

    :ssh_keys => {
      user => "ssh-rsa ...== gvarela@gmail.com"
    },

    :authorization => {
      :sudo => {
        :users => [ user, 'gabevarela' ]
      }
    },

    :mysql => {
      :server_root_password => "password",
      :bind_address => "127.0.0.1"
    },

    :ruby_enterprise => {
      :version => "1.8.7-2010.02",
      :install_path => "/usr/local",
      :ruby_bin => "/usr/local/bin/ruby",
      :gems_dir => "/usr/local/lib/ruby/gems/1.8",
      :url => "http://rubyforge.org/frs/download.php/71096/ruby-enterprise-1.8.7-2010.02.tar.gz"
    },

    :passenger_enterprise => {
      :version => "2.2.15",
      :root_path => "/usr/local/lib/ruby/gems/1.8/gems/passenger-2.2.15"
    },

    :gems => [
      {:name => 'bundler'}
    ],

    :apps => [
      {
        :name => "application_name",
        :username => user,
        :git_branch => "production",
        :server =>  "application_name.local"
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
      "gems",
      "mysql::server",
      "simple_rails_app"

    ]
  }
}

