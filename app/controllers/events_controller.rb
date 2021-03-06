class EventsController < ApplicationController

  before_action :logged_in_user
  before_action :qa_authority, only: [:new, :edit, :create, :update, :destroy, :export] #, only: [:edit, :update, :show, :index, :create, :destroy]
  #before_action :is_qa?, only: [:index, :show]


  def all_events
      @unreads = current_user.unreads
    search_params = params.except(:utf8, :commit, :controller, :action, :page)
    if search_params.present?
      @events = Event.search(search_params, @unreads).order("created_at DESC")
      @events = @events.paginate(:page => params[:page], :per_page => 5)
    else
      @events = Event.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 5)
    end
  end

  def overview
    @events = Event.all 
    @events_today = @events.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @events_7_days = @events.where("created_at >= ?", Date.today - 1.week)
  end

  def index
    @employee = Employee.find(params[:employee_id])
    @events = @employee.events.all.paginate(:page => params[:page], :per_page => 5)
    @unreads = current_user.unreads
  end

  def new
    @employee = Employee.find(params[:employee_id])
    @event = @employee.events.build
    @latest_event = @employee.events.first
  end

  def create
    @employee = Employee.find(params[:employee_id])
    @event = @employee.events.new(event_params)
    if check_if_suspended(@event, @employee)
      flash.now[:danger] = "This employee is currently suspended"
      render 'new'
    else
      if @event.save
        users = User.all.ids
        users.each do |user|
          Unread.create(user_id: user, event_id: @event.id)
        end
        if @event.incident_type == "Suspension"
          Suspension.create(employee_id: @event.employee_id, event_id: @event.id)
        end
        if params[:event][:flagged] == "1"
          Report.flagged_event(@event).deliver_now
        end
        redirect_to employee_event_path(@event.employee, @event)
      else
        render 'new'
      end 
    end
  end

  def show
    @employee = Employee.find(params[:employee_id])
    @event = @employee.events.find(params[:id])
    @unread = current_user.unreads.find_by event_id: @event.id
    @unread.destroy unless @unread.nil?
  end

  def edit
    @employee = Employee.find(params[:employee_id])
    @event = @employee.events.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:employee_id])
    @event = @employee.events.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to employee_events_path(@employee)
    else
      render 'edit'
    end
  end

  def destroy
    @employee = Employee.find(params[:employee_id])
    @event = @employee.events.find(params[:id])
    @event.destroy

    redirect_to employee_path(@employee)
  end

  def export
    @data = Event.all.order(:created_at)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.csv { send_data @data.to_csv }
    end
  end

  def employee_export
    @employee = Employee.find(params[:id])
    @data = @employee.events.all.order(:created_at)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.csv { send_data @data.to_csv }
    end
  end

  private
  def event_params
    params.require(:event).permit(:incident_type, :description, :employee_id, :user_id)
  end

end
