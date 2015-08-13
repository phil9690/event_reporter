class UsersController < ApplicationController

  before_action :logged_in_user
  before_action :correct_user, only: [:show]
  before_action :is_admin, only: [:index, :create, :destroy, :new]
  before_action :is_admin_or_sup, only: [:edit, :update]

  def index
    @users = User.all.order(last_name: :asc).paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @unreads = @user.unreads.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :authority, :password, :password_confirmation)
  end

  #  	def correct_user
  #      @user = User.find(params[:id])
  #      redirect_to(root_url) unless @user == current_user
  #    end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

end
