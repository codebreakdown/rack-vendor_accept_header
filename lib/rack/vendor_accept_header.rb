require "rack/vendor_accept_header/version"
require "rack"

module Rack
  class VendorAcceptHeader
    def initialize(app, options = {})
      @app = app
      @options = options
    end

    def call(env)
      parts = parse_accept_header(env)
      env['vnd_version'] = parts[:version]
      env['vnd_context'] = parts[:context]
      env['vnd_type'] = parts[:type]
      env['vnd_sub_type'] = parts[:sub_type]
      @app.call(env)
    end

    private

    def parse_accept_header(env)
      if env['HTTP_ACCEPT'] =~ /application\/vnd\.(\w+)\.v(\d+(?:\.\d+)*)\+(\w+)/
        return { type: 'application', context: $1, version: $2, sub_type: $3 }
      else
        return { type: nil, context: nil, version: nil, sub_type: nil }
      end
    end
  end
end
