require "test_helper"

module LightSwitch
  class SwitchesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @switch = light_switch_switches(:one)
    end

    test "should get index" do
      get switches_url
      assert_response :success
    end

    test "should get new" do
      get new_switch_url
      assert_response :success
    end

    test "should create switch" do
      assert_difference("Switch.count") do
        post switches_url, params: {switch: {name: @switch.name, state: @switch.state}}
      end

      assert_redirected_to switch_url(Switch.last)
    end

    test "should show switch" do
      get switch_url(@switch)
      assert_response :success
    end

    test "should get edit" do
      get edit_switch_url(@switch)
      assert_response :success
    end

    test "should update switch" do
      patch switch_url(@switch), params: {switch: {name: @switch.name, state: @switch.state}}
      assert_redirected_to switch_url(@switch)
    end

    test "should destroy switch" do
      assert_difference("Switch.count", -1) do
        delete switch_url(@switch)
      end

      assert_redirected_to switches_url
    end
  end
end
