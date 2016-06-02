class Registration < ApplicationRecord
  DEFAULT_ARRIVAL_TIME = Time.parse("2016-06-24 08:00")
  DEFAULT_DEPARTURE_TIME = Time.parse("2016-06-27 10:00")
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  PHONE_REGEX = /\A\+|00/ # starts with country code
  TOTAL_CABIN_PLACES = 13 * 7
  TOTAL_HOSTEL_PLACES = 11 * 2
  TOTAL_HOTEL_PLACES = 30 + 8 # Rovor & Rum + Villa
  CABIN_COST = 108
  HOSTEL_COST = 140
  TENT_COST = 55
  HOTEL_COST = 108

  has_many :participants, inverse_of: :registration, dependent: :delete_all

  accepts_nested_attributes_for :participants

  before_validation :generate_token, on: :create, unless: :token

  validates_format_of :email, with: EMAIL_REGEX, message: "Must be a valid email address."
  validates_format_of :phone, with: PHONE_REGEX, message: "Must be a valid international phone number (including country code denoted by + or 00)"
  validates_presence_of :accommodation, message: "You must select your desired type of accommodation."
  validates_presence_of :registration_type
  validate :validate_at_least_one_participant

  def self.cabin_places_left
    TOTAL_CABIN_PLACES - Participant.count_for_accommodation("cabin")
  end

  def self.hostel_places_left
    TOTAL_HOSTEL_PLACES - Participant.count_for_accommodation("hostel")
  end

  def self.hotel_places_left
    TOTAL_HOTEL_PLACES - Participant.count_for_accommodation("hotel")
  end

  def total_cost
    minimum_cost + extra.to_i
  end

  def total_cost_in_cents
    total_cost * 100
  end

  def total_cost_in_öre
    (total_cost_in_cents * FIXER_CLIENT.rate("SEK")).round
  end

  def minimum_cost
    participants.sum(&:cost)
  end

  def cost_per_participant
    accommodation_cost[accommodation]
  end

  def extra
    (read_attribute(:extra) || participants.select(&:applicable_for_donation?).length * 30).to_i
  end

  def extra_per_participant
    number_of_donators = participants.select(&:applicable_for_donation?).length

    number_of_donators.zero? ? 0 : extra / number_of_donators
  end

  def extra_per_participant=(value)
    self.extra = value.to_i * participants.select(&:applicable_for_donation?).length
  end

  def single?
    registration_type == "single"
  end

  def group?
    registration_type == "group"
  end

  def to_param
    token
  end

  private

  def validate_at_least_one_participant
    errors.add(:base, "you need to register at least one participant") if participants.none?
  end

  def accommodation_cost
    {
      "cabin" => CABIN_COST,
      "hostel" => HOSTEL_COST,
      "tent" => TENT_COST,
      "hotel" => HOTEL_COST,
    }
  end

  def generate_token
    self.token = SecureRandom.hex(4)

    while Registration.where(token: token).exists?
      self.token = SecureRandom.hex(4)
    end
  end
end
