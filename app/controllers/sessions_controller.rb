class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.

    if @user && @user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = @user.id
      flash[:notice] = 'Logged in successfully.'
      redirect_to root_path
    else
      # If user's login doesn't work, send them back to the login form.
      flash[:alert] = 'Email or password does not match.'
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out successfully.'
    redirect_to root_path
  end
end
