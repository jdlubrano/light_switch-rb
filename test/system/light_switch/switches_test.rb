require "application_system_test_case"

module LightSwitch
  class SwitchesTest < ApplicationSystemTestCase
    def index_path
      "#{light_switch_path}/#{switches_path}"
    end

    setup do
      @switch = light_switch_switches(:one)
    end

    test "visiting the index" do
      visit index_path
      assert_selector "h4", text: "Switches"

      within("tr#switch_#{@switch.id}") do
        assert_selector "td", text: @switch.name
        assert_selector "input.turn-off"
      end
    end

    test "create switch" do
      visit index_path

      fill_in "Name", with: "switch_two"
      click_on "Create Switch"

      assert_text "Switch switch_two was successfully created"
      assert LightSwitch::Switch.exists?(name: "switch_two", state: :on)

      within("tr#switch_#{LightSwitch::Switch.last.id}") do
        assert_selector "td", text: "switch_two"
      end
    end

    test "invalid switch creation" do
      visit index_path

      # Duplicate switch cannot be created
      fill_in "Name", with: @switch.name
      click_on "Create Switch"
      assert_equal LightSwitch::Switch.count, 1

      assert_text "Failed to save: Name already taken."
    end

    test "turn on Switch" do
      @switch.off!

      visit index_path

      within("tr#switch_#{@switch.id}") do
        find("input.turn-on").click
      end

      assert_text "Switch #{@switch.name} was successfully updated."
      assert @switch.reload.on?
    end

    test "turn off Switch" do
      @switch.on!

      visit index_path

      within("tr#switch_#{@switch.id}") do
        find("input.turn-off").click
      end

      assert_text "Switch #{@switch.name} was successfully updated."
      assert @switch.reload.off?
    end

    test "update deleted Switch" do
      visit index_path

      @switch.destroy!

      within("tr#switch_#{@switch.id}") do
        find("input.turn-off").click
      end

      assert_text "Failed to update Switch because it has been deleted."
    end

    test "delete Switch" do
      visit index_path

      within("tr#switch_#{@switch.id}") do
        click_on("Delete")
      end

      assert_text "Switch #{@switch.name} was successfully deleted"
      assert_equal LightSwitch::Switch.count, 0
    end
  end
end
