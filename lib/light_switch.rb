require "active_support/configurable"

require "light_switch/version"
require "light_switch/engine"

module LightSwitch
  include ActiveSupport::Configurable

  module_function

  def configure_defaults
    config.switches = []
  end
end
