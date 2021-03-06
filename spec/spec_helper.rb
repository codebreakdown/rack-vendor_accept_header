require 'simplecov'
require 'codeclimate-test-reporter'
SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]
SimpleCov.start do
  add_filter '/spec/'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rack/vendor_accept_header'

module RSpecMixin
  require 'rack/test'
  include Rack::Test::Methods
end

RSpec.configure do |c|
  c.include RSpecMixin
end
