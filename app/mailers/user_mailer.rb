class UserMailer < ApplicationMailer
  def welcome_email
    @password = params[:password]
    @mail = params[:mail]
    mail(to: @mail, subject: 'Добро пожаловать на сайт NekIdea!')
  end
end
