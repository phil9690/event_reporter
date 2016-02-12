class EmployeesController < ApplicationController

  before_action :logged_in_user
  before_action :qa_authority, only: [:new, :edit, :create, :update, :destroy]


  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = 'The employee you tried to access does not exist'
    redirect_to employees_path
  end

  def index
    if params[:first_name] || params[:last_name] || params[:inactive]
      @employees = Employee.search([params[:first_name], params[:last_name], params[:inactive]]).order("last_name DESC")
      @employees = @employees.order("last_name DESC").paginate(:page => params[:page], :per_page => 15)
    else
      @employees = Employee.active
      @employees = @employees.order("last_name ASC").paginate(:page => params[:page], :per_page => 15)
    end
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employee_path(@employee)
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
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    redirect_to employee_path
  end

  private
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :active, :pid, :trainee)
  end
end
