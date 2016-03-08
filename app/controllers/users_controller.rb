class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      redirect_to dashboard_path
    else
      flash.now[:errors] = "Invalid Account Details"
      render :new
    end
  end

  def show
    if current_user.admin?
      redirect_to admin_dashboard_path
    else
      @user = current_user
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
