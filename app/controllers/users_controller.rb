class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Signed up & logged in successfully.'
      redirect_to root_path
    else
      flash[:notice] = 'Something went wrong.'
      redirect_to signup_path
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name, 
      :email, 
      :password, 
      :password_confirmation
      )
  end
  
end
