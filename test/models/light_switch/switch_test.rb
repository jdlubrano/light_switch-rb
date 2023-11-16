require "test_helper"

module LightSwitch
  class SwitchTest < ActiveSupport::TestCase
    test "name uniqueness" do
      switch = LightSwitch::Switch.create!(name: "test")

      assert_raises(ActiveRecord::RecordNotUnique) do
        LightSwitch::Switch.create(name: "test")
      end
    end

    test "state enum" do
      switch = LightSwitch::Switch.new(name: "test")
      assert switch.on?

      switch.state = :off
      assert switch.off?

      assert_raises(ArgumentError) { switch.state = :broken }
    end

    test "validates name presence" do
      switch = LightSwitch::Switch.new(name: "test")
      assert switch.valid?

      switch.name = ""
      assert switch.invalid?
      assert_includes switch.errors[:name], "can't be blank"
    end

    test "validates state presence" do
      switch = LightSwitch::Switch.new(name: "test")
      switch.state = nil
      assert switch.invalid?
      assert_includes switch.errors[:state], "can't be blank"
    end

    test "before_validation :normalize_name" do
      switch = LightSwitch::Switch.new(name: " Test ")
      switch.validate
      assert_equal switch.name, "test"

      switch.name = nil

      assert_nothing_raised { switch.validate }
    end
  end
end
