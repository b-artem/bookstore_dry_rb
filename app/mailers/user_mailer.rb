class UserMailer < Devise::Mailer
  default template_path: 'devise/mailer'
  default from: 'notifications@bookstore-artem.herokuapp.com'

  layout 'mailer'
end
