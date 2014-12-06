require 'exception_notification'
require 'redis'

module ExceptionNotifier
  class << self
    alias_method :original_notify_exception, :notify_exception

    def notify_exception(exception, options={})
      ex_key = exception_key(exception)

      val = execute_with_rescue_error { redis.get(ex_key) }
      if val && val.to_i + 60 > Time.now.to_i
        # Write log and return.
        ExceptionNotificationModerate.logger.info(exception)
        return false
      end

      execute_with_rescue_error { redis.set(ex_key, Time.now.to_i) }
      original_notify_exception(exception, options)
    end

    private

    def exception_key(exception)
      "#{exception.to_s}_#{exception.message}"
    end

    def execute_with_rescue_error
      yield
    rescue Redis::CannotConnectError, SocketError
    end

    def redis
      if ExceptionNotificationModerate.redis_host
        Redis.new(host: ExceptionNotificationModerate.redis_host)
      elsif ExceptionNotificationModerate.redis_url
        Redis.new(host: ExceptionNotificationModerate.redis_url)
      end
    end
  end
end
