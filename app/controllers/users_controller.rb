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
  def generate
    if params["type"] == "single"
    elsif params["type"] == "csv"
      require 'csv'
      i = 0
      CSV.foreach(params["file"], headers: true) do |row|
        user = User.new(mail: row["mail"].to_s, name: row["name"].to_s,
                        surname: row["surname"].to_s)
        user.patronymic = row["patronymic"] if row["patronymic"] != nil
        user.birth_date = row["birth_date"] if row["birth_date"] != nil
        user.is_admin = row["is_admin"] if row["is_admin"] != nil
        user.rating = row["rating"] if row["rating"] != nil
        code = SecureRandom.hex(5)
        user.password = code
        user.duties << Duty.find_by(is_general: true)
        if row["duties"] != nil
          row["duties"].split(" ").each do |el|
            duty = Duty.find_by(name: el)
            user.duties << duty if duty != nil
          end
        end
        i+=1
        error_str = "В строке #{i}:\n"
        if user.save
          UserMailer.with(mail: user.mail, password: code).welcome_email.deliver_later
        end
        user.errors.messages.each do |key, value|
          error_str += value.join(". ") + "\n"
        end
        flash[:error] = error_str
        #pp row
        #pp user
      end
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
