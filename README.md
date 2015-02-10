# Heartcheck::Redis

A plugin to check redis connection with heartcheck

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'heartcheck-redis'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heartcheck-redis

## Usage

You can add a check to redis when configure the heartcheck

```ruby
Heartcheck.setup do |config|
  config.add :redis do |c|
    c.add_service(name: 'MyRedisConnection', connection: Redis.new)
  end
end
```

The service is a Hash that needs to respond to `:name` to identify the service and `:connection` that is recommended to use the redis connection that your app is using.
Ex.

```ruby
Heartcheck.setup do |config|
  config.add :redis do |c|
    c.add_service(name: 'MyRedisConnection', connection: Resque.redis)
  end
end
```

## Contributing

1. Fork it ( https://github.com/locaweb/heartcheck-redis )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
