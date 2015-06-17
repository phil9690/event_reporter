class EmployeesController < ApplicationController

  before_action :logged_in_user
  before_action :qa_authority, only: [:new, :edit, :create, :update, :destroy]


  rescue_from ActiveRecord::RecordNotFound do
		flash[:notice] = 'The employee you tried to access does not exist'
		redirect_to employees_path
	end

  def index
  	@employees = Employee.all
  end

  def new
		@employee = Employee.new
  end

  def create
  	@employee = Employee.new(employee_params)
  	if @employee.save
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  def edit
  	@employee = Employee.find(params[:id])
  end

  def update
  	@employee = Employee.find(params[:id])
  	if @employee.update_attributes(employee_params)
  		redirect_to employee_path(@employee)
  	else
  		render 'edit'
  	end
  end
  
  def show
  	@employee = Employee.find(params[:id])
  	#@event = Event.new
  end

  def destroy
  	@employee = Employee.find(params[:id])
  	@employee.destroy
  	
  	redirect_to root_path
  end
  
  private
  	def employee_params
  		params.require(:employee).permit(:first_name, :last_name)
  	end
end
