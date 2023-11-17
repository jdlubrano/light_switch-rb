require "inline_svg"
require "turbo-rails"

module LightSwitch
  class Engine < ::Rails::Engine
    isolate_namespace LightSwitch

    initializer "light_switch.assets.precompile" do |app|
      app.config.assets.precompile += ["application.js"]
    end
  end
end
