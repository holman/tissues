$LOAD_PATH.unshift 'lib'

require 'rubygems'
require 'things'

require 'vendor/octopi-0.2.9/lib/octopi'
require 'tissues/helpers'
require 'tissues/patches'
require 'tissues/sync'

module Tissues
  VERSION = '0.0.2'
end