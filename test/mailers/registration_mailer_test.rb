require 'test_helper'

class RegistrationMailerTest < ActionMailer::TestCase
  setup do
    ActionMailer::Base.default_url_options = { host: "example.com" }
  end

  test "registered" do
    registration = Registration.new(id: "test", email: "foo@bar.com")

    mail = RegistrationMailer.registered(registration)

    assert_equal "Adi Shakti Puja 2016: Registration", mail.subject
    assert_equal ["foo@bar.com"], mail.to
    assert_equal ["no-reply@test.mailgun.org"], mail.from
    assert_match "Thank you!", mail.body.encoded
  end

  test "paid" do
    registration = Registration.new(id: "test", email: "foo@bar.com", accommodation: "cabin", extra: 30)

    mail = RegistrationMailer.paid(registration)

    assert_equal "Adi Shakti Puja 2016: Receipt", mail.subject
    assert_equal ["foo@bar.com"], mail.to
    assert_equal ["no-reply@test.mailgun.org"], mail.from
    assert_match "Thank you!", mail.body.encoded
  end
end
