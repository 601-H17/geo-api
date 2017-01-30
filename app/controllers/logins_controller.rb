class LoginsController < ApplicationController

  # GET /login

  def new

  end

  # POST /login

  def create
    user = Admin.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Something wrong with your login infos"
      render 'new'
    end
  end

  # DELETE /logout

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

end