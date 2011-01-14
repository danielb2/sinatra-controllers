module Sinatra
  class Controller
    attr_accessor :params, :request, :template_cache
    include Sinatra::Templates
    def initialize(params,request)
      @params  = params
      @request = request
      @template_cache = Tilt::Cache.new rescue 'sinatra < 1.0'
      @templates = {}
    end
    class << self
      def views
      end
      def templates
        {}
      end
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
        block = proc { aklass.new(params, request).send action }
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
