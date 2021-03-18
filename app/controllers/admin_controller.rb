class AdminController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all
  end

  private
  def require_admin
    redirect_to controller: 'home', action: 'index' if current_user.nil? || !current_user.is_admin
  end
end
