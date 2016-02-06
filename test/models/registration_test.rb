require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
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
end
