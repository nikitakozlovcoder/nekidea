class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[ login_post login logout ]
  def login_post
    mail = params["mail"]
    password = params["password"]
    pp "LOGINPOST"
    user = User.find_by(mail: mail)

    if user and user.authenticate(password)
        hash = {user: user.id, time: Time.now.getutc}
        cookies.signed["user"] = {value: JSON.generate(hash), expires: params["remember"] == "on" ? 30.days : nil}
        redirect_to controller: 'home', action: 'index'
    else
      respond_to do |format|
        format.js
        format.html { redirect_to controller: 'home', action: 'index'  }
      end
      #render :login
    end
  end

  def generate
    @error_str = ""
    @type = params["type"]
    @file = params["file"]
    if params["type"] == "single"
      @user = User.new(name: params['name'], mail: params['mail'], surname: params['surname'], patronymic: params['patronymic'])
      #TODO check @user.errors
      code = SecureRandom.hex(5)
      @user.password = code
      if @user.save
        user.add_duty Duty.find_by(is_general: true)
        UserMailer.with(mail: @user.mail, password: code).welcome_email.deliver_later
      end

      p @user.errors
      respond_to do |format|
        format.json{
         render json: {user: @user.to_json, errors: @user.errors.full_messages.to_json}
        }
        format.js
      end
    elsif params["type"] == "csv"
      if params["file"] != nil
        csv_generate
      else
        respond_to do |format|
          format.json{
            render json: {errors: "no file error"}
          }
          format.js
        end
      end


    end
  end

  def login
     p "LOGIN ACTION!"
     @error = false
   end
  def logout
    cookies.signed["user"] = nil
    redirect_to controller: 'users', action: 'login'
  end


  def leaderboard

    end

  def profile
    @user = User.find(params[:id])
    @can_edit = @user.id==current_user.id
  end

  def update
    respond_to do |format|
      res = nil
      @user = current_user
      @can_edit = @user.id==current_user.id
      if params['password']
          res = @user.update(password: params['new_password'], current_password: params['password'])
      else
        @user.avatar.purge if params[:avatar_changed] == "Yes"
        @user.avatar.attach(params[:avatar]) if (!params[:avatar].nil? and  params[:avatar_changed] == "Yes")
        res = @user.update(user_params)
      end

      if res
        format.html { render :profile}
      else
        format.html { render :profile, status: :unprocessable_entity }
      end
    end
  end

  private
  def csv_generate
    require 'csv'
    i = 0
    @error = false

    CSV.foreach(@file, headers: true) do |row|
      user = User.new(mail: row["mail"].to_s, name: row["name"].to_s,
                      surname: row["surname"].to_s)
      user.patronymic = row["patronymic"] if row["patronymic"] != nil
      user.birth_date = row["birth_date"] if row["birth_date"] != nil
      user.is_admin = row["is_admin"] if row["is_admin"] != nil
      user.is_boss = row["is_boss"] if row["is_boss"] != nil
      user.rating = row["rating"] if row["rating"] != nil
      code = SecureRandom.hex(5)
      user.password = code
      saved = user.save
      user.add_duty Duty.find_by(is_general: true)
      if row["duties"] != nil and saved
        row["duties"].split(" ").each do |el|
          duty = Duty.find_by(name: el)
          user.add_duty duty if duty != nil
        end
      end
      i+=1
      @error_str += "В строке #{i}:\n"
      if saved
        UserMailer.with(mail: user.mail, password: code).welcome_email.deliver_later
      else
        @error = true
      end
      user.errors.messages.each do |key, value|
        @error_str += value.join(". ") + "\n"
      end

      #pp row
      #pp user
    end
    p @error_str

    respond_to do |format|
      format.json{
        render json: {errors: @error ? @error_str : ''}
      }
      format.js
    end

  end


  def user_params
    params.require(:user).permit(:surname, :name, :patronymic, :mail, :birth_date)
  end
end
