require "rack/vendor_accept_header/version"
require "rack"

module Rack
  ##
  # This class is Rack middleware that handles parsing vendor HTTP
  # Accept headers

  class VendorAcceptHeader
    ##
    # Construct an instance of the Rack::VendorAcceptHeader middleware
    #
    # This takes the `app` as the first argument and a hash of `options`
    # as the second argument.

    def initialize(app, options = {})
      @app = app
      @options = options
    end

    ##
    # Entry point for triggering this middleware layer
    #
    # This conforms to the rack middleware standard. This method is
    # strictly handling duping the rack middleware instance itself and
    # calling the `_call` method to perform the actual work. This is
    # done to make this rack middleware thread safe for instance
    # variable interactions within this rack middleware.

    def call(env)
      dup._call(env)
    end

    ##
    # This the workhorse of the middleware
    #
    # This method is where the business logic exists for parsing out the
    # components of the vendor HTTP Accept header and exposing them in
    # the application layer.

    def _call(env)
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
