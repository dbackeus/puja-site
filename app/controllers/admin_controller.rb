class AdminController < ApplicationController
  layout "admin"

  http_basic_authenticate_with name: "lol", password: ""

  def registrations
    @participants = Participant.all.includes(:registration)
  end
end
