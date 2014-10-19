require "exception_notification_moderate/version"

module ExceptionNotificationModerate
end

require 'exception_notification'

module ExceptionNotifier
  class << self
    alias_method :original_notify_exception, :notify_exception

    @@flg = {}

    def notify_exception(exception, options={})
      ex_key = exception_key(exception)
      # 実行チェックするような処理
      if @@flg[ex_key] && @@flg[ex_key] + 60 > Time.now.to_i
        # ログに書いて抜ける
        return false
      end
      @@flg[ex_key] = Time.now.to_i
      original_notify_exception(exception, options)
    end
    private

    def exception_key(exception)
      ex_key = "#{exception.to_s}_#{exception.message}"
    end
  end
end
