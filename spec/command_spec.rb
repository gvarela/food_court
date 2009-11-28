require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FoodCourt::Command" do
  before do
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

  context "#setup" do
    before do
      @command = FoodCourt::Command.new('setup', 'slicehost')
    end

    it "should create a chef directory" do
      File.directory?(File.join(@path, 'config/chef')).should be_true
    end

    it "should create a chef/site-cookbooks directory" do
      File.directory?(File.join(@path, 'config/chef/site-cookbooks')).should be_true
      File.directory?(File.join(@path, 'config/chef/site-cookbooks/applications')).should be_true
      File.directory?(File.join(@path, 'config/chef/site-cookbooks/applications/recipes')).should be_true
    end

    it "should create a chef/deployments directory" do
      File.directory?(File.join(@path, 'config/chef/deployments')).should be_true
    end

    it "should copy over order.rb to chef/order.rb" do
      order_path = File.join(@path, 'config/chef/order.rb')
      File.file?(order_path).should be_true
      File.read(order_path).should_not be_empty
    end
  end

  context "#configure" do
    before do
      FoodCourt::Command.new('setup', 'slicehost')
      @command = FoodCourt::Command.new('configure')
    end

    it "should eval file into @config as a hash" do
      @command.config.should be_a Hash
    end

    it "should have :dna in the config hash" do
      @command.config[:dna].should be_a Hash
    end
  end

  context "#compile" do
    before do
      FoodCourt::Command.new('setup', 'slicehost')
      @command = FoodCourt::Command.new('compile')
      @command.package
    end

    it "should compile dna.json" do
      json = ''
      Dir[File.join(@path, 'config/chef/deployments', '**', 'dna.json')].each do |file|
        json = File.read(file)
      end
      json.should include('recipes')
    end

    it "should compile solo.rb" do
      solo = ''
      Dir[File.join(@path, 'config/chef/deployments', '**', 'solo.rb')].each do |file|
        solo = File.read(file)
      end
      solo.should include('site-cookbooks')
    end
  end
end
