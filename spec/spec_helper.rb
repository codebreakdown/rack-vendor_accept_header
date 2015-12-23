require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
end

puts "DREW: #{SimpleCov.root.inspect}"

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rack/vendor_accept_header'

module RSpecMixin
  require 'rack/test'
  include Rack::Test::Methods
end

RSpec.configure do |c|
  c.include RSpecMixin
end
