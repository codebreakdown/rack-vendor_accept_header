require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rack/vendor_accept_header'

module RSpecMixin
  require 'rack/test'
  include Rack::Test::Methods
end

RSpec.configure do |c|
  c.include RSpecMixin
end
