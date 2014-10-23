require 'exception_notification'
require 'redis'

module ExceptionNotifier
  class << self
    alias_method :original_notify_exception, :notify_exception

    def notify_exception(exception, options={})
      ex_key = exception_key(exception)
      val = redis.get(ex_key)
      # 実行チェックするような処理
      if val && val.to_i + 60 > Time.now.to_i
        # ログに書いて抜ける
        return false
      end
      redis.set(ex_key, Time.now.to_i)
      original_notify_exception(exception, options)
    end

    private

    def exception_key(exception)
      ex_key = "#{exception.to_s}_#{exception.message}"
    end

    def redis
      Redis.new(ExceptionNotificationModerate.redis_host)
    end
  end
end
