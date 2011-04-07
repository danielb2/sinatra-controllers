require './test/helper'
require 'minitest/spec'
describe  "with defined scope" do
  include Rack::Test::Methods
  def app
    @app = Sinatra::Application
    @app.set :environment, :test
    @app
  end
  it "should use correct scope" do
    get '/70s_show/kelso'
    last_response.status.must_equal 200
    last_response.body.must_equal 'michael'
  end
  it "should use correct scope without leading slash using no block" do
    get '/seinfeld/cosmo'
    last_response.status.must_equal 200
    last_response.body.must_equal 'kramer'
  end
  it "should use correct scope without leading slash for block" do
    get '/seinfeld/costanza'
    last_response.status.must_equal 200
    last_response.body.must_equal 'bald'
  end
end
