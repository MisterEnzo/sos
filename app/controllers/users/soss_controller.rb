class Users::SossController < ApplicationController
  def new
  end

  def create
    location = sos_params[:location]
    user = current_user
    user.location = location
    user.save
  end
  
  private
  
  def sos_params
    params.require(:sos).permit(:location)
  end

end