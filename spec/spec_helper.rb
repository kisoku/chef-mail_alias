require 'rubygems'

require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.version = '12.04'
  config.platform = 'ubuntu'
end
