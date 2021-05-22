class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :check_schedule
  skip_forgery_protection
  helper_method :current_user
  def current_user
    return User.first
    #puts "I am working 1111111111111111111111111"

    if cookies.signed["user"]
      #puts "I am working 22222222222222222222222222222"
      hash = JSON.parse(cookies.signed["user"])
      @current_user ||= User.find_by(id: hash["user"])
      pp @current_user
      pp hash
      if @current_user and @current_user.restore_date <= hash["time"]
        #puts "I am working 33333333333333333333333"
        @current_user
      else
        #puts "I am working 444444444444444444444"
        nil
      end
    else
      #puts "I am working 5555555555555555555555555555555555"
      nil
    end

  end


  def require_login
    #redirect_to controller: 'users', action: 'login' if current_user.nil?
  end

  def check_schedule
    cur_day = DateTime.now.to_date
    sc = Schedule.first
    if sc.checked_at == nil or cur_day != sc.checked_at.to_date
      Vote.where.not(vote_status: 'archived').each{|v| v.update_iteration}
      sc.update checked_at: DateTime.now
      p "check_schedule task fired"
    end

    p "check_schedule"
  end
end
