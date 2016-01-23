class Participant < ApplicationRecord
  belongs_to :registration

  validates_presence_of :name
  #validates_inclusion_of :gender, in: ["Male", "Female"]
  #validates_inclusion_of :age, in: ["child", "yuva", "adult"]
end
