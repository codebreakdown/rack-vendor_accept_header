require "spec_helper"

describe "Rack::VendorAcceptHeader" do
  let!(:app) {
    @app = Rack::Builder.new do
      use Rack::VendorAcceptHeader
      run lambda { |env| [200, {}, []] }
    end
  }

  it "has a version number" do
    expect(Rack::VendorAcceptHeader::VERSION).not_to be nil
  end

  context "when not given a vendor mimetype accept header" do
    it "vnd_version is nil" do
      get '/', {}, 'HTTP_ACCEPT' => 'application/json'
      expect(last_request.env['vnd_version']).to be_nil
    end

    it "vnd_context is nil" do
      get '/', {}, 'HTTP_ACCEPT' => 'application/json'
      expect(last_request.env['vnd_context']).to be_nil
    end

    it "vnd_type is nil" do
      get '/', {}, 'HTTP_ACCEPT' => 'application/json'
      expect(last_request.env['vnd_type']).to be_nil
    end

    it "vnd_sub_type is nil" do
      get '/', {}, 'HTTP_ACCEPT' => 'application/json'
      expect(last_request.env['vnd_sub_type']).to be_nil
    end
  end

  context "when given a valid vendor mimetype accept header" do
    it "extracts the context" do
      get '/', {}, 'HTTP_ACCEPT' => 'application/vnd.acme.v1+json'
      expect(last_request.env['vnd_context']).to eq('acme')
    end

    it "extracts single digit versions" do
      get '/', {}, 'HTTP_ACCEPT' => 'application/vnd.acme.v5+json'
      expect(last_request.env['vnd_version']).to eq('5')
    end

    it "extracts double digit versions" do
      get '/', {}, 'HTTP_ACCEPT' => 'application/vnd.acme.v1.2+json'
      expect(last_request.env['vnd_version']).to eq('1.2')
    end

    it "extracts tripple digit versions" do
      get '/', {}, 'HTTP_ACCEPT' => 'application/vnd.acme.v1.2.3+json'
      expect(last_request.env['vnd_version']).to eq('1.2.3')
    end

    it "extracts the type" do
      get '/', {}, 'HTTP_ACCEPT' => 'application/vnd.acme.v2+json'
      expect(last_request.env['vnd_type']).to eq('application')
    end

    it "extracts the sub type" do
      get '/', {}, 'HTTP_ACCEPT' => 'application/vnd.acme.v2+json'
      expect(last_request.env['vnd_sub_type']).to eq('json')
    end
  end
end
