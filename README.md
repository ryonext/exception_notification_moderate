[![Build Status](https://travis-ci.org/ryonext/exception_notification_moderate.svg?branch=master)](https://travis-ci.org/ryonext/exception_notification_moderate)

# ExceptionNotificationModerate

This gem blocks same error notifications that is sended by ExceptionNotification in short time.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'exception_notification_moderate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exception_notification_moderate

## Usage

* Set Redis Host
* Set logger class

```
ExceptionNotificationModerate.configure do |config|
  config.redis_host = 'localhost:6379'
  config.logger = Logger.new('./log/ex_notification.log')
end
```

## Contributing

1. Fork it ( https://github.com/ryonext/exception_notification_moderate/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
