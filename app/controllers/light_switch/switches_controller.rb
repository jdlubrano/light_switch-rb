module LightSwitch
  class SwitchesController < ApplicationController
    before_action :load_switches, on: %i[index create]

    def index
      @switch = Switch.new
    end

    def create
      @switch = Switch.new(switch_params.slice(:name))

      if @switch.save
        redirect_to [:switches], notice: "Switch #{@switch.name} was successfully created.", status: :see_other
      else
        render :index, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotUnique
      @switch.errors.add(:name, "already taken")
      render :index, status: :unprocessable_entity
    end

    def update
      @switch = Switch.find(params[:id])

      if @switch.update(switch_params.slice(:state))
        redirect_to [:switches], notice: "Switch #{@switch.name} was successfully updated.", status: :see_other
      else
        errors = @switch.errors.full_messages.to_sentence
        @switch.restore_attributes
        redirect_to [:switches], alert: "Failed to update Switch #{@switch.name}: #{errors}", status: :see_other
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to [:switches], alert: "Failed to update Switch because it has been deleted", status: :see_other
    end

    def destroy
      switch = Switch.find_by(id: params[:id])
      switch&.destroy!
      redirect_to [:switches], notice: "Switch #{switch.name} was successfully destroyed.", status: :see_other
    end

    private

    def load_switches
      @switches = Switch.ordered
    end

    def switch_params
      params.require(:switch).permit(:name, :state)
    end
  end
end
