class Admin::DashboardsController < Admin::BaseController
  def show
    @user = current_user
  end
end
