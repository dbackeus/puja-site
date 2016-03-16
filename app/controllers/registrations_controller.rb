class RegistrationsController < ApplicationController
  def show
    @registration = Registration.find_by_token!(params[:id])
  end

  def new
    @registration = Registration.new(
      registration_type: "group",
      country: request.location.try(:country),
    )
    @registration.participants.build
    @registration.participants.build # last will be removed
  end

  def create
    @registration = Registration.new(registration_params)

    if @registration.save
      RegistrationMailer.registered(@registration).deliver

      redirect_to registration_path(@registration), notice: "<strong>Thank you for your registration!</strong> An email confirmation has been sent to <strong>#{@registration.email}</strong>."
    else
      @registration.participants.build # last will be removed
      render :new
    end
  end

  def pay
    @registration = Registration.find_by_token!(params[:id])

    unless @registration.paid?
      @registration.update_attributes!(
        extra_per_participant: registration_params[:extra_per_participant]
      )

      customer = Stripe::Customer.create(
        email: @registration.email,
        source: registration_params[:stripe_token],
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: @registration.total_cost_in_öre,
        description: "Payment for registration: #{@registration.to_param}",
        currency: "SEK",
      )

      @registration.update_attributes!(
        stripe_token: registration_params[:stripe_token],
        stripe_customer_id: customer.id,
        stripe_charge_id: charge.id,
        paid: true,
      )

      RegistrationMailer.paid(@registration).deliver
    end

    redirect_to registration_path(@registration), notice: "Your payment was successfully charged! A receipt has been sent to <strong>#{@registration.email}</strong>."
  rescue Stripe::CardError => e
    Rails.logger.warn "Payment failed:"
    Rails.logger.warn e.message
    @registration.update_attribute(:stripe_token, registration_params[:stripe_token])
    redirect_to registration_path(@registration), error: e.message
  end

  private

  def registration_params
    params.require(:registration).permit!
  end
end
