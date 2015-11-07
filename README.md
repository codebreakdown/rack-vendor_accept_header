# Rack::VendorAcceptHeader

Welcome to the `rack-vendor_accept_header` gem. It provides
[rack](http://rack.github.io) middleware that parses [vendor based mime
types](https://tools.ietf.org/html/rfc4288#section-3.2) in the HTTP
Accept header.

```http
GET /something HTTP/1.1
Accept: application/vnd.acme.v3+json
```

The primary impetus for doing this is to be able to use vendor mime
types in the HTTP Accept header for REST API versioning as well as for
content negotiation. The [GitHub API's usage of Media
Types](https://developer.github.com/v3/media/) is an excellent example
of this.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-vendor_accept_header'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-vendor_accept_header

## Usage

Given that this is [rack](http://rack.github.io) middleware, it can be
used with pure [rack](http://rack.github.io) applications, or with the
vast number of web frameworks that are built on top of
[rack](http://rack.github.io). This includes [Ruby on
Rails](http://rubyonrails.org), [Sinatra](http://www.sinatrarb.com),
[Grape](http://intridea.github.io/grape/), etc. Details on using
[rack](http://rack.github.io) middleware within each of these framework
can be found within their respective documentation. However, the
following is a quick example of how you would register this
[rack](http://rack.github.io) middleware in
[Sinatra](http://www.sinatrarb.com).

```ruby
use Rack::VendorAcceptHeader
```

When you use this middleware it parses and exposes the `type`, `sub_type`,
`context`, and `version` out of the vendor based mime type HTTP Accept
header.

```http
GET /something HTTP/1.1
Accept: application/vnd.acme.v3+json
```

Given the example above this middleware would expose these components in
the [rack](http://rack.github.io) env as follows:

```ruby
request.env['vnd_type']     # => 'application'
request.env['vnd_sub_type'] # => 'json'
request.env['vnd_version']  # => '3'
request.env['vnd_context']  # => 'acme'
```

## References

If you are interested in any of the references around this use case and
the details around it. Please see the following.

- [GitHub API Media Types](https://developer.github.com/v3/media/)
- [rfc2616 sec14 - Header Field Definitions](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html)
- [rfc4288 sec3.2 - Media Type Specifications and Registration Procedures](https://tools.ietf.org/html/rfc4288#section-3.2)
- [Using the Accept Header to version your API](http://labs.qandidate.com/blog/2014/10/16/using-the-accept-header-to-version-your-api/)
- [Pivotal Labs - API Versioning](https://blog.pivotal.io/labs/labs/api-versioning)
- [Nobody Understands REST or HTTP](http://blog.steveklabnik.com/posts/2011-07-03-nobody-understands-rest-or-http)
- [MIMETYPES (AND APIS)](https://daveyshafik.com/archives/35507-mimetypes-and-apis.html)
- [Versioning REST Web Services](http://barelyenough.org/blog/2008/05/versioning-rest-web-services/)

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake
install`. To release a new version, update the version number in
`version.rb`, and then run `bundle exec rake release`, which will create
a git tag for the version, push git commits and tags, and push the
`.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/codebreakdown/rack-vendor_accept_header. This project
is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [Contributor
Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).

