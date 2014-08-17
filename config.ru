# This is an example config.ru, it will serve the /examples directory
require 'rhp/server'

run RHP::Server.new(File.join(File.dirname(__FILE__), 'examples'))
