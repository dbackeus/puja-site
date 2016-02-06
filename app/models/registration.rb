class Registration < ApplicationRecord
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  PHONE_REGEX = /\A\+|00/ # starts with country code

  has_many :participants, inverse_of: :registration, dependent: :delete_all

  accepts_nested_attributes_for :participants

  validates_format_of :email, with: EMAIL_REGEX, message: "Must be a valid email address."
  validates_format_of :phone, with: PHONE_REGEX, message: "Must be a valid international phone number (including country code denoted by + or 00)"
  validates_presence_of :country
  validates_presence_of :accommodation, message: "You must select your desired type of accommodation."
  validates_presence_of :registration_type

  def total_cost
    minimum_cost + extra.to_i
  end

  def total_cost_in_cents
    total_cost * 100
  end

  def minimum_cost
    participants.length * cost_per_participant
  end

  def cost_per_participant
    accommodation_cost[accommodation]
  end

  def extra
    read_attribute(:extra) || participants.length * 30
  end

  def single?
    registration_type == "single"
  end

  def group?
    registration_type == "group"
  end

  private

  def accommodation_cost
    {
      "cabin" => 108,
      "hostel" => 120,
      "tent" => 50,
    }
  end
end
