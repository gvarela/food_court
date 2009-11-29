$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'food_court'
require 'spec'
require 'spec/autorun'
require 'fakefs'
require 'fakefs/spec_helpers'


Spec::Runner.configure do |config|
  config.include FakeFS::SpecHelpers
end

def stub_template
  @path = File.expand_path(File.dirname(__FILE__) + '/fixtures')
    ENV['PATH'] = @path

    @order = File.open( File.join( FoodCourt::Command::TEMPLATE_PATH, '/slicehost', 'order.rb'), 'w' ) do |f|
      f.write <<-EOH
{
  :file_cache_path => "/var/chef",
  :cookbooks => [ '' ],

  :dna => {
    :apps_dir => "/data/my_app",
    :applications => [
        {
            :name => "my_app",
            :server_name => "my_app.com",
            :server_aliases => ["www.my_app.com"],
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
      EOH

    end
    @default_recipe = File.open( File.join( FoodCourt::Command::TEMPLATE_PATH, '/slicehost/site-cookbooks/applications/recipes', 'default.rb'), 'w' ) { |f| f.write 'test' }
end
