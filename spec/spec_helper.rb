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
