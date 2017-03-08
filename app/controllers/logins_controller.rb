class LoginsController < ApplicationController

  # GET /login

  def new
    if logged_in?
      redirect_to map_path
    end
  end

  # POST /login

  def create
    admin = Admin.find_by(email: params[:logins][:email].downcase)
    if admin && admin.authenticate(params[:logins][:password])
      session[:admin_id] = admin.id
      flash[:success] = "Connecté avec succès."
      redirect_to map_path
    else
      flash.now[:danger] = "Une erreur est survenue."
      render 'new'
    end
  end

  # DELETE /logout

  def destroy
    session[:admin_id] = nil
    flash[:success] = "Vous êtes déconnecté."
    redirect_to login_path
  end

end