require "test_helper"

class LightSwitchTest < ActiveSupport::TestCase
  setup do
    @switch = LightSwitch[:test]
  end

  test "it has a version number" do
    assert LightSwitch::VERSION
  end

  test "default configuration" do
    assert LightSwitch.config.cache.is_a?(LightSwitch::NullCache)
    assert_equal(LightSwitch.config.switches, [])
  end

  test ".[]" do
    assert_kind_of LightSwitch::Switch, @switch
    assert @switch.on?
  end

  test ".[] caching" do
    @switch.off!

    LightSwitch.config.cache = ActiveSupport::Cache::MemoryStore.new

    switch = LightSwitch[:test]

    assert_kind_of LightSwitch::Switch, switch
    assert switch.off?

    @switch.delete

    # Test that value is in cache
    switch = LightSwitch[:test]
    assert switch.off?
  ensure
    LightSwitch.configure_defaults
  end

  test ".on?" do
    assert LightSwitch.on?(:test)

    @switch.off!

    assert_not LightSwitch.on?(:test)
  end

  test ".off?" do
    @switch.off!

    assert LightSwitch.off?(:test)
    assert_not LightSwitch.on?(:test)
  end
end
