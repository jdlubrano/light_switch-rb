require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test

  include LightSwitch::Engine.routes.url_helpers
  include Rails.application.routes.url_helpers
end
