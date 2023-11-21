require "test_helper"

class LightSwitchTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert LightSwitch::VERSION
  end

  test "default configuration" do
    assert LightSwitch.config.cache.is_a?(LightSwitch::NullCache)
    assert_equal(LightSwitch.config.switches, [])
  end
end
