class SessionsController < ApplicationController

  #before_action :logged_in_user, only: [:new, :create]

  def new
    if logged_in?
      redirect_to current_user
    end 
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination' #not right
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
