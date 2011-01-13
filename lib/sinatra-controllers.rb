module Sinatra
  module Controller
    attr_accessor :params, :request
    def initialize(params,request)
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
        test = proc { aklass.new(params,request).send action }
        Sinatra::Application.get path, &test
      end
    end

    class << self
      def register(klass, opts={})
        yield Mapping.new(klass,opts)
      end
    end
  end
end
