require "active_support/configurable"

require "light_switch/version"
require "light_switch/engine"
require "light_switch/null_cache"

module LightSwitch
  include ActiveSupport::Configurable

  module_function

  def configure_defaults
    config.cache = NullCache.new
    config.switches = []
  end
end
