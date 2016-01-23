class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
    @registration.participants.build # first can be filled in
    @registration.participants.build # last will be removed
  end

  def create
    @registration = Registration.new(registration_params)

    if @registration.save
    else
      @registration.participants.build # last will be removed
      render :new
    end
  end

  private

  def registration_params
    params.require(:registration).permit!
  end
end
