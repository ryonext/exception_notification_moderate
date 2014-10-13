require "exception_notification_moderate/version"

module ExceptionNotificationModerate
  # Your code goes here...
end

require 'exception_notification'

module ExceptionNotifier
  class << self
    alias_method :original_notify_exception, :notify_exception

    @@flg = {}

    def notify_exception(exception, options={})
      # 実行チェックするような処理
      if @@flg[exception] && @@flg[exception] + 60 < Time.now.to_i
        # ログに書いて抜ける
        return false
      end
      @@flg[exception] = Time.now.to_i
      original_notify_exception(exception, options)
    end
  end
end
