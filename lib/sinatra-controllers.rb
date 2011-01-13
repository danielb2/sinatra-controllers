module Sinatra
  module Controllers
    class Mapping
      attr_accessor :klass, :opts
      def initialize(klass,opts={})
        @klass = klass
        @opts  = opts
      end
      def get(path, action, opts={})
        aklass = klass # need this so it will stay in scope for closure
        test = proc { aklass.new.send action }
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
