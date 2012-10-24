# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongo_logger/version"

Gem::Specification.new do |s|
  s.name        = "mongo_logger"
  s.version     = MongoLogger::VERSION
  s.authors     = ["Peter Bui"]
  s.email       = ["peter@8tracks.com"]
  s.homepage    = ""
  s.summary     = %q{Easy application logging tool utilizing mongo}
  s.description = %q{Easy application logging tool utilizing mongo}

  s.rubyforge_project = "mongo_logger"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "mongo", "~> 1.7.0"
  s.add_runtime_dependency "bson", "~> 1.7.0"
  s.add_runtime_dependency "bson_ext", "~> 1.7.0"
end
