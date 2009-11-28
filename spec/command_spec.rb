require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FoodCourt::Command" do
  before do
    @order = File.open( File.join( FoodCourt::Command::TEMPLATE_PATH, '/slicehost', 'order.rb'), 'w' ) { |f| f.write '{}' }
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
      File.read(order_path).should == '{}'
    end
  end
end
