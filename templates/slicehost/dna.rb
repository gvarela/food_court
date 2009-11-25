application = "my_application"

{
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