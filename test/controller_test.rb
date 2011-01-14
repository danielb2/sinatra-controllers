require 'rack/test'
require 'test/unit'
require './test/fixtures/sinatra_application'

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

  def test_param_pass
    get '/test/232'
    assert_equal 200, last_response.status
    assert_equal true, (last_response.body =~ /232/) != nil
  end

  def test_help_route
    get '/help'
    assert_equal 200, last_response.status
  end

end
