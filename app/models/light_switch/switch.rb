module LightSwitch
  class Switch < ApplicationRecord
    include NotificationsConcern

    if Gem::Version.new(Rails.version) >= Gem::Version.new("7.2")
      enum :state, {on: "on", off: "off"}
    else
      enum state: {on: "on", off: "off"}
    end

    scope :ordered, -> { order(:name) }

    validates :name, :state, presence: true

    before_validation :normalize_name

    after_save :delete_from_cache

    private

    def delete_from_cache
      LightSwitch.config.cache.delete("#{self.class.name.underscore}/#{name}")
    end

    def normalize_name
      name.tap(&:strip!).downcase! if name.present?
    end
  end
end
