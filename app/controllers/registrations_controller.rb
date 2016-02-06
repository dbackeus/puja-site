class RegistrationsController < ApplicationController
  def show
    @registration = Registration.find(params[:id])
  end

  def single
    @registration = Registration.new(registration_type: "single")
    @registration.participants.build
  end

  def group
    @registration = Registration.new(registration_type: "group")
    @registration.participants.build
    @registration.participants.build # last will be removed
  end

  def new
  end

  def create
    @registration = Registration.new(registration_params)

    if @registration.save
      redirect_to registration_path(@registration), notice: "<strong>Thank you for your registration!</strong>"
    else
      if @registration.registration_type == "group"
        @registration.participants.build # last will be removed
        render :group
      else
        render :single
      end
    end
  end

  private

  def registration_params
    params.require(:registration).permit!
  end
end
