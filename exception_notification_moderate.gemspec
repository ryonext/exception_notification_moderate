# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exception_notification_moderate/version'

Gem::Specification.new do |spec|
  spec.name          = "exception_notification_moderate"
  spec.version       = ExceptionNotificationModerate::VERSION
  spec.authors       = ["ryonext"]
  spec.email         = ["ryonext.s@gmail.com"]
  spec.summary       = %q{Notify same exception moderate.}
  spec.description   = %q{When system raises same errors in short time, it blocks second and later notifications}
  spec.homepage      = "http://github.com/ryonext/exception_notification_moderate"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'exception_notification', "~> 4.0"
  spec.add_dependency 'redis'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "mock_redis"
end
