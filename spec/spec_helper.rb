require 'rubygems'
require 'bundler/setup'
require 'exception_notification_moderate'
require 'timecop'
require 'pry-byebug'
require 'mock_redis'
require 'redis'

RSpec.configure do |config|
  config.before :each do
    redis_instance = MockRedis.new
    allow(Redis).to receive(:new).and_return(redis_instance)
  end
end


