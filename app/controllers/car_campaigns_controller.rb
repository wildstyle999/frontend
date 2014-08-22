class CarCampaignsController < ApplicationController
  def show
    @car_campaign = CarCampaign.new(params[:id])
    render :show
  end

  private

  def display_menu_button_in_header?
    false
  end
end
