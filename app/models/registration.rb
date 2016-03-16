class Registration < ApplicationRecord
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  PHONE_REGEX = /\A\+|00/ # starts with country code
  TOTAL_CABIN_PLACES = 12 * 7
  TOTAL_HOSTEL_PLACES = 11 * 2
  CABIN_COST = 108
  HOSTEL_COST = 140
  TENT_COST = 55

  has_many :participants, inverse_of: :registration, dependent: :delete_all

  accepts_nested_attributes_for :participants

  before_validation :generate_token, on: :create, unless: :token

  validates_format_of :email, with: EMAIL_REGEX, message: "Must be a valid email address."
  validates_format_of :phone, with: PHONE_REGEX, message: "Must be a valid international phone number (including country code denoted by + or 00)"
  validates_presence_of :accommodation, message: "You must select your desired type of accommodation."
  validates_presence_of :registration_type

  def self.cabin_places_left
    TOTAL_CABIN_PLACES - Participant.count_for_accommodation("cabin")
  end

  def self.hostel_places_left
    TOTAL_HOSTEL_PLACES - Participant.count_for_accommodation("hostel")
  end

  def total_cost
    minimum_cost + extra.to_i
  end

  def total_cost_in_cents
    total_cost * 100
  end

  def total_cost_in_öre
    (total_cost_in_cents * 9.2235).round
  end

  def minimum_cost
    participants.sum(&:cost)
  end

  def cost_per_participant
    accommodation_cost[accommodation]
  end

  def extra
    read_attribute(:extra) || participants.select(&:applicable_for_donation?).length * 30
  end

  def extra_per_participant
    extra / participants.select(&:applicable_for_donation?).length
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

  def accommodation_cost
    {
      "cabin" => CABIN_COST,
      "hostel" => HOSTEL_COST,
      "tent" => TENT_COST,
    }
  end

  def generate_token
    self.token = SecureRandom.hex(4)

    while Registration.where(token: token).exists?
      self.token = SecureRandom.hex(4)
    end
  end
end
