require 'rack/test'
require 'test/unit'
require 'minitest/autorun'
require 'ap'
require './test/fixtures/sinatra_application'
require './test/helper'

class ClassicMappingTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    @app = Sinatra::Application
    @app.set :environment, :test
    @app
  end

  def test_render
    get '/'
    assert_equal 200, last_response.status
    assert_equal true, (last_response.body =~ /message/) != nil
  end

  def test_fringe
    get '/fringe'
    assert_equal 200, last_response.status
    assert_equal true, (last_response.body =~ /bishop/) != nil
    assert_equal true, (last_response.body =~ /Anna Torv/) != nil
  end

  def test_param_pass
    get '/test/232'
    assert_equal 200, last_response.status
    assert_equal true, (last_response.body =~ /232/) != nil
  end

  def test_help_route
    get '/help'
    assert_equal 200, last_response.status
  end
  def test_help_index
    get '/help/index'
    assert_equal 200, last_response.status
    assert_equal true, (last_response.body =~ /help found/) != nil
  end

  def test_regular
    get '/regular'
    assert_equal 200, last_response.status
    assert_equal true, (last_response.body =~ /flames/) != nil
  end

  def test_all
    delete '/all'
    assert_equal 200, last_response.status
    assert_equal true, (last_response.body =~ /wiped/) != nil
  end

  def test_flame
    put '/flame'
    assert_equal 200, last_response.status
    assert_equal true, (last_response.body =~ /heat/) != nil
  end

  def test_request
    get '/request'
    assert_equal 200, last_response.status
    assert_equal true, (last_response.body =~ /SCRIPT_NAME/) != nil
  end

  def test_post
    post '/racket'
    assert_equal 200, last_response.status
    assert_equal true, (last_response.body =~ /posted/) != nil
  end
  def test_arguments
    get '/take/123'
    assert_equal 200, last_response.status
    assert_equal true, (last_response.body =~ /123/) != nil
  end
end
