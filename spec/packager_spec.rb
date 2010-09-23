require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FoodCourt::Packager" do
  before do
    stub_template
  end

  context "#configure" do
    before do
      FoodCourt::Command.new('init', 'slicehost')
      @packager = FoodCourt::Packager.new(@path)
      @packager.configure
    end

    it "should eval file into @config as a hash" do
      @packager.config.should be_a Hash
    end

    it "should have :dna in the config hash" do
      @packager.config[:dna].should be_a Hash
    end
  end

  context "#compile" do
    before do
      FoodCourt::Command.new('init', 'slicehost')
      @packager = FoodCourt::Packager.new(@path)
      @packager.should_receive(:`).with("cd #{File.expand_path( File.join( File.dirname(__FILE__), 'fixtures', 'config/chef/deployments', Time.now.strftime('%Y-%m-%d-%H-%M-%S'))) } && tar czvf site-cookbooks.tar.gz site-cookbooks").and_return(true)
      @packager.configure
      @packager.compile
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
