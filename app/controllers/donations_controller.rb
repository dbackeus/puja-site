class DonationsController < ApplicationController
  def scandinavia
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(
      params.require(:donation).permit(:amount, :stripe_token)
    )

    if @donation.save
      render :create
    else
      render :scandinavia
    end
  end
end
