class Registration < ApplicationRecord
  has_many :participants

  accepts_nested_attributes_for :participants

  validates_presence_of :email
  validates_presence_of :phone
  validates_presence_of :country

  attr_accessor :accomodation
end
