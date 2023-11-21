require "test_helper"

module LightSwitch
  class NullCacheTest < ActiveSupport::TestCase
    setup do
      @cache = NullCache.new
    end

    test "#fetch caches nothing" do
      access_count = 0

      result = @cache.fetch("test") do
        access_count += 1
        "foo"
      end

      assert_equal result, "foo"

      result = @cache.fetch("test") do
        access_count += 1
        "bar"
      end

      assert_equal result, "bar"
      assert_equal access_count, 2
    end

    test "#delete does nothing" do
      assert_nothing_raised { @cache.delete("foo") }
    end
  end
end
