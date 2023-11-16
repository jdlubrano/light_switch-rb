module LightSwitch
  class Switch < ApplicationRecord
    enum state: { on: "on", off: "off" }

    scope :ordered, -> { order(:name) }

    validates :name, :state, presence: true

    before_validation :normalize_name

    private

    def normalize_name
      self.name.tap(&:strip!).downcase! if name.present?
    end
  end
end
