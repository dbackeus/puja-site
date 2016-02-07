# Preview all emails at http://localhost:3000/rails/mailers/registration_mailer
class RegistrationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/registration_mailer/registered
  def registered
    RegistrationMailer.registered(registration)
  end

  def paid
    RegistrationMailer.paid(registration)
  end

  private

  def registration
    Registration.new(id: "test", email: "foo@bar.com", accommodation: "cabin", extra: 30)
  end
end
