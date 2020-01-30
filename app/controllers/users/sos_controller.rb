class Users::SosController < ApplicationController
  def new
  end

  def create
    location = location_params[:location]
    user = current_user
    user.location = location
    user.save
  end
  
  private
  
  def location_params
    params.permit(:location)
  end

end