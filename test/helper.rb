require 'rubygems'
require 'bundler/setup'
require 'rack/test'
require 'test/unit'
require 'minitest/autorun'
require 'awesome_print'
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

