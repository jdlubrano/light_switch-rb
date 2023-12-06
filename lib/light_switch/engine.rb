require "inline_svg"
require "turbo-rails"

module LightSwitch
  class Engine < ::Rails::Engine
    isolate_namespace LightSwitch

    config.before_configuration { LightSwitch.configure_defaults }

    initializer "light_switch.assets.precompile" do |app|
      app.config.assets.precompile += [
        "light_switch/application.css",
        "light_switch/application.js",
        "light_switch/light-switch.svg"
      ]
    end

    initializer "light_switch.create_switches", after: :load_config_initializers do
      ActiveSupport.on_load(:active_record) do
        LightSwitch.config.switches.each do |name|
          Switch.find_or_create_by!(name: name) if Switch.table_exists?
        rescue ActiveRecord::RecordNotUnique
        end
      end
    end
  end
end
