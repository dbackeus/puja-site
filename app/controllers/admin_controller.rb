class AdminController < ApplicationController
  layout "admin"

  http_basic_authenticate_with name: "lol", password: ""

  def registrations
    @participants = Participant.all.includes(:registration)
  end

  def transport
    @registrations = Registration.where(transport: true).where.not(departure_at: nil).includes(:participants)
    @pending_registrations = Registration.where(transport: true).where(departure_at: nil).includes(:participants)
  end
end
