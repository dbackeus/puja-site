require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  test "token generation" do
    registration = Registration.new

    registration.validate

    assert_equal 8, registration.token.length
  end

  ["", "0760 47 83 86"].each do |number|
    test "doesn't accept: '#{number}' as phone number" do
      registration = Registration.new(phone: number)

      registration.validate

      assert_includes registration.errors[:phone], "Must be a valid international phone number (including country code denoted by + or 00)"
    end
  end

  ["0046 0760 47 83 86", "+46760478386"].each do |number|
    test "accepts: '#{number}' as phone number" do
      registration = Registration.new(phone: number)

      registration.validate

      refute_includes registration.errors[:phone], "Must be a valid international phone number (including country code denoted by + or 00)"
    end
  end

  test "#extra" do
    assert_equal 0, Registration.new.extra

    registration = Registration.new(accommodation: "cabin")
    registration.participants.build

    assert_equal 30, registration.extra

    registration.participants.build

    assert_equal 60, registration.extra

    assert_equal 108, Registration.new(extra: 108).extra
  end

  test "#to_param" do
    registration = Registration.new(token: "foo")

    assert_equal "foo", registration.to_param
  end
end
