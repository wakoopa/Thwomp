$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'yaml'
require 'rspec'
require 'thwomp'

def get_contents(file)
  File.open(file, 'rb') { |f| f.read }
end

Thwomp::Renderer.gnash_binary = '/usr/local/gnash-dump/bin/dump-gnash'
