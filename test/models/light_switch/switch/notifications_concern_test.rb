require "test_helper"

module LightSwitch
  class SwitchNotificationsConcernTest < ActiveSupport::TestCase
    NotificationCallback = Struct.new(:call_count, :switch) do
      def call(_name, _start, _finish, _unique_id, payload)
        self.call_count ||= 0
        self.call_count += 1
        self.switch = payload[:switch]
      end
    end

    test "create_committed notification" do
      callback = NotificationCallback.new

      ActiveSupport::Notifications.subscribed(callback, "create_committed.switch.light_switch") do
        LightSwitch::Switch.create!(name: "test")
      end

      assert_equal 1, callback.call_count
      assert_kind_of LightSwitch::Switch, callback.switch
    end

    test "destroy_committed notification" do
      callback = NotificationCallback.new
      switch = LightSwitch::Switch.create!(name: "test")

      ActiveSupport::Notifications.subscribed(callback, "destroy_committed.switch.light_switch") do
        switch.destroy
      end

      assert_equal 1, callback.call_count
      assert_kind_of LightSwitch::Switch, callback.switch
    end

    test "update_committed notification" do
      callback = NotificationCallback.new
      switch = LightSwitch::Switch.create!(name: "test")

      ActiveSupport::Notifications.subscribed(callback, "update_committed.switch.light_switch") do
        switch.off!
        switch.on!
        switch.on! # No changes, should not publish
      end

      assert_equal 2, callback.call_count
      assert_kind_of LightSwitch::Switch, callback.switch
    end
  end
end
