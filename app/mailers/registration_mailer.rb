class RegistrationMailer < ApplicationMailer
  default(
    from: "Adi Shakti Puja 2016 <no-reply@#{ENV.fetch("MAILGUN_DOMAIN")}>",
    reply_to: "adishaktipuja+registration@gmail.com",
  )

  def money_update(registration)
    @registration = registration

    mail(
      to: registration.email,
      subject: "Adi Shakti Puja 2016: Payment Reminder",
      bcc: ["duztdruid@gmail.com"],
    )
  end

  def transport_update(registration)
    @registration = registration

    mail(
      to: registration.email,
      subject: "Adi Shakti Puja 2016: Transportation Update",
      bcc: ["duztdruid@gmail.com"],
    )
  end

  def registered(registration)
    @registration = registration

    mail(
      to: registration.email,
      subject: "Adi Shakti Puja 2016: Registration",
      bcc: ["duztdruid@gmail.com"],
    )
  end

  def paid(registration)
    @registration = registration

    mail(
      to: registration.email,
      subject: "Adi Shakti Puja 2016: Receipt",
      bcc: ["duztdruid@gmail.com"],
    )
  end

  def final_welcome(registration)
    @registration = registration

    mail(
      to: registration.email,
      subject: "Adi Shakti Puja 2016: Welcome to Scandinavia!",
      bcc: ["duztdruid@gmail.com"],
    )
  end
end
