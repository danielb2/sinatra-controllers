require 'sinatra'
class Sinatra::Application
  def env
    @env.update('SCRIPT_NAME' => '/test')
  end
end
require 'sinatra-controllers'

class Blah < Sinatra::Controller
  def help
    @blah = 'message' + params.inspect
    haml :foo
  end
  def test
    params.inspect
  end

  def requested
    request.inspect
  end

  def racket
    'posted'
  end
end
class Help < Sinatra::Controller
  def help
    'another help'
  end
end
Sinatra::Controllers.register(Help) do |route|
  route.get '/help', :help
end
Sinatra::Controllers.register(Blah) do |route|
  route.get '/request', :requested
  route.get '/', :help
  route.get '/test/:id', :test
  route.post '/racket', :racket
end

# regular paths should work too
get '/regular' do
  'flames'
end
