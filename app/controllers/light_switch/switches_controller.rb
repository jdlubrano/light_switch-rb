module LightSwitch
  class SwitchesController < ApplicationController
    before_action :set_switch, only: %i[update]

    def index
      @switches = Switch.ordered
    end

    def update
      if @switch.update(switch_params)
        redirect_to :index, notice: "Switch #{@switch.name} was successfully updated.", status: :see_other
      else
        render :index, status: :unprocessable_entity
      end
    end

    def destroy
      switch = Switch.find_by(id: params[:id])
      switch&.destroy!
      redirect_to :index, notice: "Switch #{switch.name} was successfully destroyed.", status: :see_other
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_switch
      @switch = Switch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def switch_params
      params.require(:switch).permit(:state)
    end
  end
end
