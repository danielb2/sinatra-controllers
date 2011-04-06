
require 'minitest/spec'
describe  "without defined route block" do
  include Rack::Test::Methods
  def app
    @app = Sinatra::Application
    @app.set :environment, :test
    @app
  end
  it "should respond to get" do
    get '/welcome/index'
    last_response.status.must_equal 200
    last_response.body.must_match /route test/
  end
  it "should respond to put" do
    put '/welcome/update'
    last_response.status.must_equal 200
    last_response.body.must_match /walternet/
  end
  it "should respond to post" do
    post '/welcome/peter'
    last_response.status.must_equal 200
    last_response.body.must_match /amber/
  end
  it "should respond to delete" do
    delete '/welcome/universe'
    last_response.status.must_equal 200
    last_response.body.must_match /destroy/
  end
end
