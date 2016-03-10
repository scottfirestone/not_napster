class Admin::InfosController < Admin::BaseController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:info] = "Your info has been updated!"
      redirect_to admin_dashboard_path
    else
      flash.now[:errors] = "Invalid Info"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
