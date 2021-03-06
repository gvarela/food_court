require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FoodCourt::Command" do
  before do
    stub_template
  end

  context "#init" do
    before do
      @command = FoodCourt::Command.new('init', 'slicehost')
    end

    it "should create a chef directory" do
      File.directory?(File.join(@path, 'config/chef')).should be_true
    end

    it "should create a chef/site-cookbooks directory" do
      File.directory?(File.join(@path, 'config/chef/site-cookbooks')).should be_true
    end

    it "should create a chef/deployments directory" do
      File.directory?(File.join(@path, 'config/chef/deployments')).should be_true
    end

    it "should copy over order.rb to chef/order.rb" do
      order_path = File.join(@path, 'config/chef/order.rb')
      File.file?(order_path).should be_true
      File.read(order_path).should_not be_empty
    end

    context "#create_cookbooks" do
      before do
        @command = FoodCourt::Command.new('create_cookbook', 'sample')
      end

      it "should create a stub cookbook" do
        File.directory?(File.join(@path, 'config/chef/site-cookbooks/sample')).should be_true
      end
    end
  end

end
