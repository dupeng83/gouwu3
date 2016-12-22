class Admin::ApplicationController < ApplicationController
  before_action :authorize_admin!

  def index
  end

  private

  def authorize_admin!
    authenticate_user!

    unless current_user.admin?
      redirect_to root_path, alert: "必须是管理员才能访问"
    end
  end
end
