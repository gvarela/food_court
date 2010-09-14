application = "my_application"

{
  :file_cache_path => "/var/chef",
  :cookbooks => { 'cookbooks' => 'http://github.com/opscode/cookbooks/tarball/master' },

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
        "git",
        "mysql",
        "passenger",
        "nginx",
        "applications"
    ]
}
}
