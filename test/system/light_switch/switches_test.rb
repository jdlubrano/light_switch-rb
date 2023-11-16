require "application_system_test_case"

module LightSwitch
  class SwitchesTest < ApplicationSystemTestCase
    setup do
      @switch = light_switch_switches(:one)
    end

    test "visiting the index" do
      visit switches_url
      assert_selector "h1", text: "Switches"
    end

    test "should create switch" do
      visit switches_url
      click_on "New switch"

      fill_in "Name", with: @switch.name
      fill_in "State", with: @switch.state
      click_on "Create Switch"

      assert_text "Switch was successfully created"
      click_on "Back"
    end

    test "should update Switch" do
      visit switch_url(@switch)
      click_on "Edit this switch", match: :first

      fill_in "Name", with: @switch.name
      fill_in "State", with: @switch.state
      click_on "Update Switch"

      assert_text "Switch was successfully updated"
      click_on "Back"
    end

    test "should destroy Switch" do
      visit switch_url(@switch)
      click_on "Destroy this switch", match: :first

      assert_text "Switch was successfully destroyed"
    end
  end
end
