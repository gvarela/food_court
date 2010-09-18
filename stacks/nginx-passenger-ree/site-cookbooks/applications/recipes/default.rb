directory(node[:apps_dir])

node[:applications].each do |config|
  name = config[:name]
  config[:env] ||= "production"
  config[:server_name] ||= node[:fqdn]
  config[:server_aliases] ||= []
  config[:port] ||= 80
  app_dir = "#{node[:apps_dir]}/#{name}"

  bash "create application folder" do
    user app[:username]
    code "mkdir -p #{app_dir}"
    code "mkdir -p #{app_dir}/shared"
    code "mkdir -p #{app_dir}/current"
    not_if { File.exists?(app_dir) }
  end


  nginx_app do
    current_dir "#{app_dir}/current"
    shared_dir "#{app_dir}/shared"
    template "passenger.vhost.erb"
    server_name config[:server_name]
    server_aliases config[:server_aliases]
    rails_env config[:env]
    port config[:port] || "80"
  end
end
