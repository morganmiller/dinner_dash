class SessionsController < ApplicationController
  def new
    if current_user
      flash[:notice] = "You're already logged in!"
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome #{@user.display_name}!"
      redirect_to root_path
    else
      flash.now[:errors] = "Invalid Login"
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
