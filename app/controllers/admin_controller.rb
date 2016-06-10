class AdminController < ApplicationController
  layout "admin"

  http_basic_authenticate_with name: "lol", password: ""

  def registrations
    @participants = Participant.all.order(:created_at).includes(:registration)
  end

  def transport
    registrations_with_transport = Registration
      .order(:created_at)
      .includes(:participants)
      .where(transport: true, transport_registered_at: nil)

    @registrations = registrations_with_transport.select do |registration|
      registration.arrival_at.present? || registration.departure_at.present?
    end

    @pending_registrations = registrations_with_transport - @registrations

    # @completed_registrations = Registration
    #   .order(:created_at)
    #   .includes(:participants)
    #   .where.not(transport_registered_at: nil)
  end

  def mark_transports_as_registered
    Registration
      .where(id: params[:registrations][:ids].split())
      .update_all(transport_registered_at: Time.now)

    redirect_to admin_transport_path
  end
end
