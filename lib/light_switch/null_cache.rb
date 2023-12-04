module LightSwitch
  class NullCache
    def fetch(_key)
      yield if block_given?
    end

    def delete(_key)
    end
  end
end
