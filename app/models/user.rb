class User < ApplicationRecord
  has_secure_password
  validates_presence_of :username, :email, :password, on: :create
  validates :email, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  has_many :reservations
  has_many :hotels, through: :reservations
  has_many :cities, through: :hotels
  has_many :reviews, through: :reservations


  def self.from_omniauth(auth)
    self.find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |u|
      u.email = auth["info"]["email"]
      u.username = auth['info']['name'].downcase.gsub(" ", "_")
      u.password = SecureRandom.hex(20)
    end
  end

  def find_hotel(hotel_id)
    self.hotels.distinct.find_by(id: hotel_id)
  end

  # Used by the API to show a hotel reservation offer; needs to use native Ruby methods as the offer is not persited in database
  def unbooked_reservation(hotel)
    hotel.reservations.find{|reservation| reservation.id == nil && reservation.user_id = self.id}
  end

  # For the current user, find the user's reservations for the given hotel, and order them from most recent to least recent checkin date
  def booked_reservations(hotel)
    self.reservations.where("hotel_id = ?", hotel.id)
  end

  def most_recent_reservation(hotel)
    booked_reservations(hotel).order(checkin_date: :desc).first
  end

  # For the current user, find the user's hotels for the given city and sort them by most recent checkin date
  def hotels_by_city(city_id)
    self.hotels.distinct.where("city_id = ?", city_id).includes(:reservations).order(checkin_date: :desc)
  end

  def all_hotels_sorted
    self.hotels.distinct.includes(:reservations).order(checkin_date: :desc)
  end

  def all_reviews_sorted
    self.reviews.includes(:reservation).order(checkin_date: :desc)
  end

  def all_reservations_sorted
    self.reservations.order(checkin_date: :desc)
  end

  def upcoming_reservations(hotel = nil)
    if hotel
      booked_reservations(hotel).where("checkin_date >= :todays_date", {todays_date: Date.today.to_s}).includes(hotel: [:city]).order(checkin_date: :asc)
    else
      self.reservations.where("checkin_date >= ?", Date.today.to_s).includes(hotel: [:city]).order(checkin_date: :asc)
    end
  end

  def previous_reservations(hotel = nil)
    if hotel
      booked_reservations(hotel).where("checkin_date < :todays_date", {todays_date: Date.today.to_s}).includes(hotel: [:city]).order(checkin_date: :desc)
    else
      self.reservations.where("checkin_date < ?", Date.today.to_s).includes(hotel: [:city]).order(checkin_date: :desc)
    end
  end

  def open_for_review_reservations
    self.reservations.where("checkout_date < ?", Date.today.to_s).includes(:review).where(review: {id: nil })
  end

end
