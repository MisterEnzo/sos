class StaticController < ApplicationController
  before_action :send_to_sos
  def home
  end

  private

  def send_to_sos
    redirect_to sos_path if current_user
  end

end
