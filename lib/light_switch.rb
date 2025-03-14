require "active_support/configurable"

require "light_switch/version"
require "light_switch/engine"
require "light_switch/null_cache"

module LightSwitch
  include ActiveSupport::Configurable

  module_function

  def configure_defaults
    config.cache = NullCache.new

    config.cache_fetch_options = {
      expires_in: 86_400,     # 1 day
      race_condition_ttl: 300 # 5 minutes
    }

    config.switches = []
  end

  def [](switch_name)
    config.cache.fetch("#{LightSwitch::Switch.name.underscore}/#{switch_name}", **config.cache_fetch_options) do
      LightSwitch::Switch.find_or_initialize_by(name: switch_name)
    end
  end

  def on?(switch_name)
    self[switch_name].on?
  end

  def off?(switch_name)
    self[switch_name].off?
  end
end
