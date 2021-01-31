class ApplicationController < ActionController::Base
  skip_forgery_protection
  helper_method :current_user
  def current_user
    puts "I am working 1111111111111111111111111"
    if cookies.signed["user"]
      puts "I am working 22222222222222222222222222222"
      hash = JSON.parse(cookies.signed["user"])
      @current_user ||= User.find_by(id: hash["user"])
      pp @current_user
      pp hash
      if @current_user and @current_user.restore_date <= hash["time"]
        puts "I am working 33333333333333333333333"
        @current_user
      else
        puts "I am working 444444444444444444444"
        nil
      end
    else
      puts "I am working 5555555555555555555555555555555555"
      nil
    end

  end
end
