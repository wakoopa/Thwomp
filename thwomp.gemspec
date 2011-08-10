# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "thwomp/version"

Gem::Specification.new do |s|
  s.name        = "thwomp"
  s.version     = Thwomp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Wakoopa"]
  s.email       = ["webmaster@altovista.nl"]
  s.homepage    = ""
  s.summary     = %q{}
  s.description = %q{}
  #s.extensions  = ['ext/gnash/extconf.rb']

  s.rubyforge_project = "thwomp"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
