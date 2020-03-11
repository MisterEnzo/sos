class Users::SossController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_user_has_no_contacts
  
  def new
  end

  def create
    location = sos_params[:location]
    user = current_user
    user.location = location
    user.save
    SosMailer.with(user: user).send_sos.deliver_now
  end
  
  private
  
  def sos_params
    params.require(:sos).permit(:location)
  end

  def redirect_if_user_has_no_contacts
    redirect_to new_contact_path if current_user.contacts.count == 0
  end

end