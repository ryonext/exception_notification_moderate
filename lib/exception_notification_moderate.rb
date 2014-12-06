require 'exception_notification_moderate/version'
require 'active_support/configurable'
require 'exception_notifier'
require 'exception_notification_moderate/exception_notifier'

module ExceptionNotificationModerate
  include ActiveSupport::Configurable
  config_accessor :redis_host
  config_accessor :redis_url
  config_accessor :logger
end
