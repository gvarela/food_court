application = "my_application"

{
  :file_cache_path => "/var/chef",
  :keep_deployments => 2,
  :cookbooks => [ '' ],

  :dna => {
    :apps_dir => "/data/#{application}",
    :applications => [
        {
            :name => application,
            :server_name => "#{application}.com",
            :server_aliases => ["www.#{application}.com"],
            }
    ],
    :recipes => [
        "mysql",
        "nginx",
        "passenger",
        "applications"
    ]
}
}