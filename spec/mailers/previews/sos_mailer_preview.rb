# Preview all emails at http://localhost:3000/rails/mailers/sos_mailer
class SosMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/sos_mailer/send
  def send
    user = User.first
    SosMailer.with(user: user).send
  end

end
