# frozen_string_literal: true

require 'heartcheck/redis'
require 'pry-nav'

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = :expect
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
