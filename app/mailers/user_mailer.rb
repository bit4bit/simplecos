class UserMailer < ActionMailer::Base
  default from: "minutero@neurotec.co"

  #notifica que ya no hay
  #balance en la cuenta y debe recargar
  def balance_out_email(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('email.balance_out_email.subject'))
  end

  #notifica que de nuevo hay balance
  #balance en la cuenta y debe recargar
  def balance_in_email(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('email.balance_in_email.subject'))
  end
  
end
