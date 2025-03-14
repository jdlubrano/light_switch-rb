# frozen_string_literal: true

unless LightSwitch::Switch.exists?(name: :switch_defined_in_initializer, state: :on)
  raise "LightSwitch initializer failed to create switches"
end
