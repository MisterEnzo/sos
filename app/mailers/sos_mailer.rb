class SosMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sos_mailer.send.subject
  #
  def send
    @user = params[:user]
    contacts = @user.contacts.pluck(:email)
    mail to: contacts[0], subject: "Emergency SOS from #{@user.name}"
  end
  
end
