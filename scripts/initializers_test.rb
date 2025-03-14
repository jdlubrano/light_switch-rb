ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path("../db/migrate", __dir__)
require "rails/test_help"
require "minitest/mock"

module LightSwitch
  class InitializerTest < ActiveSupport::TestCase
    test "switches configured in an initializer get created" do
      assert LightSwitch::Switch.exists?(name: :switch_defined_in_initializer, state: :on)
    end
  end
end
