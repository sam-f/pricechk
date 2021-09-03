# frozen_string_literal: true

require "coingecko_ruby"

class Price
  def self.current(crypto:, currency:)
    new(crypto, currency).current
  end

  def self.yesterday(crypto:, currency:)
    new(crypto, currency).yesterday
  end

  def initialize(crypto, currency)
    @crypto = crypto
    @currency = currency
  end

  def current
    historical_prices = client.hourly_historical_price(crypto, currency: currency, days: 1)
    historical_prices["prices"].last.last
  end

  def yesterday
    historical_prices = client.daily_historical_price(crypto, currency: currency, days: 1)
    historical_prices["prices"].first.last
  end

  private

  attr_reader :crypto, :currency

  def client
    @client ||= CoingeckoRuby::Client.new
  end
end
