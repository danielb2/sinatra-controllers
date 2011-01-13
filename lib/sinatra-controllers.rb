module Sinatra
  module Controller
    attr_accessor :params, :request
    private
    def setup_controller(params,request)
      @params  = params
      @request = request
    end
  end
  module Controllers
    class Mapping
      attr_accessor :klass, :opts
      def initialize(klass,opts={})
        @klass = klass
        @opts  = opts
      end
      def get(path, action, opts={})
        aklass = klass # need this so it will stay in scope for closure
        block = proc do
          inst = aklass.new
          inst.send :setup_controller, params, request
          inst.send action
        end
        Sinatra::Application.get path, &block
      end
    end

    class << self
      def register(klass, opts={})
        yield Mapping.new(klass,opts)
      end
    end
  end
end
