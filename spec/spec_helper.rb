require 'signantia_analysis'

require 'data_mapper'
require 'factory_girl'
require 'factories'

RSpec.configure do |config|
  config.before(:suite) {
    DataMapper.setup(
      :default,
      "sqlite::memory:"
      )
    }
  
  config.before(:each) {
    DataMapper.auto_migrate!
    
    DataMapper.finalize
    }
end
