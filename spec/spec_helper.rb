require 'codeclimate-test-reporter'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rack/vendor_accept_header'

require 'rack/test'

module RSpecMixin
  include Rack::Test::Methods
end

RSpec.configure do |c|
  c.include RSpecMixin
end
