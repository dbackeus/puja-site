require "open-uri"

class Fixer
  def initialize
    @rates = {
      "SEK" => ENV["SEK_CONVERSION_RATE"].to_f
    }

    Thread.new do
      loop do
        Rollbar.info "Fetching exchange rates..."
        fetch_exchange_rates
        sleep 1.hour
      end
    end
  end

  def rate(currency)
    @rates[currency]
  end

  private

  def fetch_exchange_rates
    response = open("http://api.fixer.io/latest").read
    @rates = JSON.parse(response)["rates"]
  rescue => e
    Rollbar.error(e)
  end
end
