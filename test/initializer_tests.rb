raise RuntimeError, "LightSwitch initializer failed" unless LightSwitch::Switch.exists?(name: :dummy, state: :on)
