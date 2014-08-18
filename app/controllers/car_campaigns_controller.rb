class CarCampaignsController < ApplicationController
  def show
    render :show
  end

  private

  def display_menu_button_in_header?
    false
  end
end
