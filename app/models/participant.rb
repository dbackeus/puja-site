class Participant < ApplicationRecord
  belongs_to :registration, inverse_of: :participants

  validates_presence_of :name
  validates_inclusion_of :gender, in: %w[male female]
  validates_inclusion_of :age, in: %w[child yuva adult]

  def self.count_for_accommodation(accommodation)
    joins(:registration).where(registrations: { accommodation: accommodation }).count
  end
end
