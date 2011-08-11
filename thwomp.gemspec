# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "thwomp/version"

Gem::Specification.new do |s|
  s.name        = "thwomp"
  s.version     = Thwomp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Altovista"]
  s.email       = ["webmaster@altovista.nl"]
  s.homepage    = "http://www.wakoopa.nl"
  s.summary     = %q{Create thumbnails or gif animations from SWF files}
  s.description = %q{Creates thumbnails or gif animations using Gnash as SWF renderer}

  s.rubyforge_project = "thwomp"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'
  s.add_dependency 'oily_png'
end
