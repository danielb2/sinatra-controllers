require './test/helper'
require 'minitest/spec'

class Show70 < Sinatra::Controller
  def get_kelso
    'michael'
  end
end

class Seinfeld < Sinatra::Controller
  def get_cosmo
    'kramer'
  end
  def george
    'bald'
  end
end

class Leader < Sinatra::Controller
  def omit
    'slash'
  end
end

Sinatra::Controllers.register(Show70, :scope => '/70s_show')
# make sure we don't need leading slash
Sinatra::Controllers.register(Seinfeld, :scope => 'seinfeld') do
  get 'costanza', :george
end

describe  "with defined scope" do
  include Rack::Test::Methods
  def app
    @app = Sinatra::Application
    @app.set :environment, :test
    @app
  end

  it "should not bail on empty scope without preceding slash" do
    Sinatra::Controllers.register(Leader) do
      get 'foo', :omit
    end
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
