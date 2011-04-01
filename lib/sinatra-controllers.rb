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
      def route(verb, path, action, opts={})
        aklass = klass # need this so it will stay in scope for closure
        block = proc { aklass.new(params, request).send action }
        Sinatra::Application.send verb, path, &block
      end
      # why are these even defined?
      undef_method :get, :post, :put, :delete
      def method_missing(method,*a)
        case method.to_s
        when /(get|post|delete|put)/
          route(method, *a)
        else
          super
        end
      end
    end

    class << self
      def register(klass, opts={}, &block)
        Mapping.new(klass,opts).instance_eval(&block)
      end
    end
  end
end
