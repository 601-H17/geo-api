class LoginsController < ApplicationController

  # GET /login

  def new
    if logged_in?
      redirect_to admins_path
    end
  end

  # POST /login

  def create
    admin = Admin.find_by(email: params[:logins][:email].downcase)
    if admin && admin.authenticate(params[:logins][:password])
      session[:admin_id] = admin.id
      flash[:success] = "Successfully logged in"
      redirect_to admin_path(admin)
    else
      flash.now[:danger] = "Something wrong with your login infos"
      render 'new'
    end
  end

  # DELETE /logout

  def destroy
    session[:admin_id] = nil
    flash[:success] = "You have logged out"
    redirect_to login_path
  end

end