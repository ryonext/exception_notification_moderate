require 'exception_notification'
require 'redis'

module ExceptionNotifier
  class << self
    alias_method :original_notify_exception, :notify_exception

    def notify_exception(exception, options={})
      ex_key = exception_key(exception)
      begin
        val = redis.get(ex_key)
      rescue Redis::CannotConnectError
      end
      if val && val.to_i + 60 > Time.now.to_i
        # Write log and return.
        ExceptionNotificationModerate.logger.info(exception)
        return false
      end

      begin
        redis.set(ex_key, Time.now.to_i)
      rescue Redis::CannotConnectError
      end
      original_notify_exception(exception, options)
    end

    private

    def exception_key(exception)
      "#{exception.to_s}_#{exception.message}"
    end

    def redis
      Redis.new(ExceptionNotificationModerate.redis_host)
    end
  end
end
