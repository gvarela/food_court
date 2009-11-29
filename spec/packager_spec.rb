require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FoodCourt::Packager" do
  before do
    stub_template
  end

  context "#configure" do
    before do
      FoodCourt::Command.new('setup', 'slicehost')
      @command = FoodCourt::Packager.new(@path)
      @command.configure
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
      @command = FoodCourt::Packager.new(@path)
      @command.configure
      @command.compile
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
