class Participant < ApplicationRecord
  DONATING_AGES = %w[yuva adult].freeze

  belongs_to :registration, inverse_of: :participants

  validates_presence_of :name
  validates_inclusion_of :gender, in: %w[male female]
  validates_inclusion_of :age, in: %w[small_child child yuva adult]

  # Excludes small children since they should be able to sleep with parents
  def self.count_for_accommodation(accommodation)
    joins(:registration)
      .where(registrations: { accommodation: accommodation })
      .where.not(age: "small_child")
      .count
  end

  def cost
    if age == "small_child"
      0
    else
      registration.cost_per_participant
    end
  end

  def donation
    if applicable_for_donation?
      registration.extra_per_participant
    else
      0
    end
  end

  def applicable_for_donation?
    DONATING_AGES.include? age
  end
end
