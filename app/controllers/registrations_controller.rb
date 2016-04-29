class RegistrationsController < ApplicationController
  def show
    @registration = Registration.find_by_token!(params[:id])
  end

  def new
    @registration = Registration.new(
      registration_type: "group",
      country: country_from_ip,
    )
    @registration.participants.build
    @registration.participants.build # last will be removed
  end

  def create
    @registration = Registration.new(
      registration_params.merge(ip_address: request.remote_ip)
    )

    if @registration.save
      RegistrationMailer.registered(@registration).deliver

      redirect_to registration_path(@registration), notice: "<strong>Thank you for your registration!</strong> An email confirmation has been sent to <strong>#{@registration.email}</strong>."
    else
      @registration.participants.build # last will be removed
      render :new
    end
  end

  def update
    registration = Registration.find_by_token!(params[:id])

    registration.update_attributes!(update_params)

    redirect_to registration, notice: "Your registration was updated!"
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

    maybe_transport = "You may now fill in your transport details at the bottom of this page." if @registration.transport?
    redirect_to registration_path(@registration), notice: "Your payment was successfully charged! A receipt has been sent to <strong>#{@registration.email}</strong>. #{maybe_transport}"
  rescue Stripe::CardError => e
    Rails.logger.warn "Payment failed: #{e.message}"
    @registration.update_attribute(:stripe_token, registration_params[:stripe_token])
    redirect_to registration_path(@registration), alert: "<p><b>Credit card payment failed</b>.</p><p>The error message given was: <i>#{e.message}</i></p><p>If you can not make the payment work with credit card you may consider paying with international bank transfer (see instructions at the bottom of this page).</p>"
  end

  private

  def update_params
    params.require(:registration).permit(
      :arrival_at,
      :departure_at,
      :arrival_flight_no,
      :departure_flight_no,
    )
  end

  def country_from_ip
    request.location.country
  rescue => e
    Rollbar.error(e)
    nil
  end

  def registration_params
    params.require(:registration).permit!
  end
end
