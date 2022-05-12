require 'amadeus'


class AmadeusApi
  attr_accessor :amadeus
  @@all = []
  @@collection = []

  def initialize()
    @amadeus = Amadeus::Client.new({
      client_id: "#{ENV['AMADEUS_API_KEY']}",
      client_secret: "#{ENV['AMADEUS_API_SECRET']}"
    })

    @@all << self
  end

  def self.all
    @@all
  end

  def self.hotels
    @@collection
  end

  def query_city(citycode, checkin_date = Date.today.to_s, checkout_date = (Date.today+1).to_s, guests = 2, user_id)
      response = @amadeus.shopping.hotel_offers.get(
        cityCode: citycode,
        checkInDate: checkin_date,
        checkOutDate: checkout_date,
        adults: guests,
        currency: "EUR"
      ).data
    parse_city_responnse(response, user_id)
  end

  def parse_city_responnse(response, user_id)
    response.each do |hotel_hash|
      @@collection << Hotel.build_hotel(hotel_hash, user_id)
    end
    @@collection
  end

end
