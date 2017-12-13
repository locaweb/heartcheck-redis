# Heartcheck::Redis

[![Build Status](https://travis-ci.org/locaweb/heartcheck-redis.svg)](https://travis-ci.org/locaweb/heartcheck-redis)
[![Code Climate](https://codeclimate.com/github/locaweb/heartcheck-redis/badges/gpa.svg)](https://codeclimate.com/github/locaweb/heartcheck-redis)
[![Ebert](https://ebertapp.io/github/locaweb/heartcheck-redis.svg)](https://ebertapp.io/github/locaweb/heartcheck-redis)

##A plugin to check redis connection with [heartcheck](https://github.com/locaweb/heartcheck).


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

You can check any redis connection that there's in your app.
Each service need to respond to `:name` (an indetifier) and `:connection` (an activerecord connection)

```ruby
Heartcheck.setup do |config|
  config.add :redis do |c|
    c.add_service(name: 'MyRedisConnection', connection: Redis.new)
  end
end
```

### For ruby old versions (older than ruby-2.2.2)

If You are using an old version of Ruby, You may run Bundle's script with a specific gemfile.

```shell
    $ bundle install --gemfile=Gemfile-old-ruby
```

### Check Heartcheck example [here](https://github.com/locaweb/heartcheck/blob/master/lib/heartcheck/generators/templates/config.rb)

## License
* [MIT License](https://github.com/locaweb/heartcheck-redis/blob/master/LICENSE.txt)

## Contributing

1. Fork it ( https://github.com/locaweb/heartcheck-redis )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
