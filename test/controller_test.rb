require 'rack/test'
require 'test/unit'
require 'minitest/autorun'
require 'ap'
require './test/fixtures/sinatra_application'

class Pride
  def print o
    case o
    when /0 errors/i
      Kernel.print o.green
    when /(e|f)/i
      Kernel.print o.red
    else
      Kernel.print o.green
    end
  end
  def puts o = ''
    if o=~ /([1-9]+ failures)/
      o.sub!(/([1-9]+ failures)/, '\1'.red)
    end
    Kernel.puts o
  end
end
MiniTest::Unit.output = Pride.new

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

  def test_regular
    get '/regular'
    assert_equal 200, last_response.status
    assert_equal true, (last_response.body =~ /flames/) != nil
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
end
