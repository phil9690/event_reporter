module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end
	
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
	
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def user_name
    current_user.first_name.humanize + " " + current_user.last_name.humanize
  end
  
  def is_admin?
    current_user.authority == "admin"
  end

  def is_sup?
    current_user.authority == "supervisor"
  end
  
  
  def is_admin
    unless is_admin?
      flash[:danger] = "You do not have the authority to access this."
      if logged_in?
      	redirect_to user_path(current_user)
      else
      	redirect_to login_path
      end
    end
  end

  def is_admin_or_sup
    unless is_admin? || is_sup?
      flash[:danger] = "You do not have the authority to access this."
      if logged_in?
        redirect_to user_path(current_user)
      else
        redirect_to login_path
      end
    end
  end

  
  def is_qa?
    current_user.authority == "qa"
  end

  def qa_authority
      if is_qa?
        flash[:danger] = "You do not have authority to access this."
        redirect_to user_path(current_user)
      end
    end

  
  def correct_user
    if logged_in?
      unless is_admin?
        @user = User.find(params[:id])
	unless @user == current_user
	  flash[:danger] = "You do not have the authority to access this."
	  redirect_to user_path(current_user)
	end
      end
    else
      redirect_to root_path
    end
  end
  
end
