class UsersController < ApplicationController
  def login_post
    mail = params["mail"]
    password = params["password"]
    user = User.find_by(mail: mail)
    #noinspection RubyResolve
    if user and user.authenticate(password)
        @error = false
        puts "11111111111111111111"
        puts "logged"
        hash = {user: user.id, time: Time.now.getutc}
        cookies.signed["user"] = {value: JSON.generate(hash), expires: params["remember"] == "on" ? 30.days : nil}
        redirect_to controller: 'home', action: 'index'
    else
      puts "111111111111"
      puts "no logged"
        @error = true
        render :login
    end
  end

   def login
        @error = false

   end
   def logout
        cookies.signed["user"] = nil
        redirect_to controller: 'home', action: 'index'
   end
end
