class Participant < ApplicationRecord
  belongs_to :registration, inverse_of: :participants

  validates_presence_of :name
  validates_inclusion_of :gender, in: %w[male female]
  validates_inclusion_of :age, in: %w[child yuva adult]
end
