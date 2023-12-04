module LightSwitch::Switch::NotificationsConcern
  extend ActiveSupport::Concern

  included do
    after_commit :publish_committed, if: :saved_changes?
  end

  private

  def publish_committed
    event = if previously_new_record?
      :create
    elsif destroyed?
      :destroy
    else
      :update
    end

    ActiveSupport::Notifications.instrument("#{event}_committed.switch.light_switch", switch: self) do
      # Do nothing; just publishing the event for subscribers
    end
  end
end
