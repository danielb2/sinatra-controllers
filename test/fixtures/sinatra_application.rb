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
  def fringe
    @fringe = "Anna Torv"
    haml :fringe
  end
  def take
    params[:arg]
  end
end

class Help < Sinatra::Controller
  def help
    'another help'
  end
  def get_index
    'help found'
  end
end

class Welcome < Sinatra::Controller
  def get_index
    'route test'
  end
  def put_update
    'walternet'
  end
  def post_peter
    'amber'
  end
  def delete_universe
    'destroy'
  end
end

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

Sinatra::Controllers.register(Show70, :scope => '/70s_show')
# make sure we don't need leading slash
Sinatra::Controllers.register(Seinfeld, :scope => 'seinfeld') do
  get 'costanza', :george
end

Sinatra::Controllers.register(Welcome)

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
  get '/fringe', :fringe
  get '/take/:arg', :take
end



# regular path should work too
get '/regular' do
  'flames'
end
