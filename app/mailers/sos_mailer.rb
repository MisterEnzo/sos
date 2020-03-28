class SosMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sos_mailer.send.subject
  #
  def send_sos
    @user = params[:user]
    contacts = @user.contacts.pluck(:email)
    mail to: contacts, subject: "Emergency SOS from #{@user.name}"
  end

  def send_sos_confirmation
    @user = params[:user]
    mail to: @user.email, subject: "#{@user.name}, you just sent an SOS to your contacts"
  end
end
