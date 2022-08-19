class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :check_schedule
  skip_forgery_protection
  helper_method :current_user
  def current_user

    if cookies.signed["user"]
      hash = JSON.parse(cookies.signed["user"])
      @current_user ||= User.find_by(id: hash["user"])
    
      if @current_user and @current_user.restore_date <= hash["time"]
        @current_user
      else
        nil
      end
    else
      nil
    end

  end


  def require_login
    redirect_to controller: 'users', action: 'login' if current_user.nil?
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
