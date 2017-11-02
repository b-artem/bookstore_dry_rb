class UserMailer < ApplicationMailer
  default from: 'bookstore-notifications@example.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: t('mailers.user.welcome'))
  end
end
