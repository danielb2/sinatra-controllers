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

  def flames
    'heat'
  end

  def requested
    request.inspect
  end

  def racket
    'posted'
  end

  def everything
    'wiped'
  end
end
class Help < Sinatra::Controller
  def help
    'another help'
  end
end
Sinatra::Controllers.register(Help) do
  get '/help', :help
end
Sinatra::Controllers.register(Blah) do
  get '/request', :requested
  get '/', :help
  get '/test/:id', :test
  post '/racket', :racket
  put '/flame', :flames
  delete '/all', :everything
end

# regular paths should work too
get '/regular' do
  'flames'
end
