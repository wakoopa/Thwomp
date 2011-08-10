$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'yaml'
require 'rspec'

$enabled = false

original_stdout = $stdout
$stdout = StringIO.new
