class Registration < ApplicationRecord
  has_many :participants

  accepts_nested_attributes_for :participants

  validates_presence_of :email
  validates_presence_of :phone
  validates_presence_of :country
  validates_presence_of :accommodation
  validates_presence_of :registration_type

  def single?
    registration_type == "single"
  end

  def group?
    registration_type == "group"
  end
end
