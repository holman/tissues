require 'rubygems'
require 'test/unit'
require 'spec/mini'
require 'mocha'

require 'tissues'

begin
  require 'redgreen'
rescue LoadError
end

class Test::Unit::TestCase
end