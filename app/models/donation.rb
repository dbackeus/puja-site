class Donation < ApplicationRecord
  validates_presence_of :stripe_charge_id
  validates_presence_of :stripe_token
  validates_presence_of :amount

  before_validation :pay!, on: :create

  private

  def amount_in_öre
     (amount_in_cents * FIXER_CLIENT.rate("SEK")).round
  end

  def amount_in_cents
    amount * 100
  end

  def pay!
    return unless amount && stripe_token

    charge = Stripe::Charge.create(
      source: stripe_token,
      amount: amount_in_öre,
      description: "Donation from Scandinavian collective",
      currency: "SEK",
    )

    self.stripe_charge_id = charge.id
  rescue Stripe::CardError => e
    errors.add(:base, "Payment failed with the error: #{e.message}")
  end
end
