class Users::SossController < ApplicationController
  def new
  end

  def create
    location = sos_params[:location]
    user = current_user
    user.location = location
    user.save
    UserMailer.with(user: current_user).send_sos.deliver_now
  end
  
  private
  
  def sos_params
    params.require(:sos).permit(:location)
  end

end