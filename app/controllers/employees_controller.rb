class EmployeesController < ApplicationController

  HEADER = { "Accept" => "application/json",
             "X-User-Email" => ENV['API_EMAIL'],
             "Authorization" => "Token token=#{ENV['API_KEY']}"}
  def index
    @employees = Employee.all
    render :index
    # render "index.html.erb"
  end

  def show
    @employee = Employee.find_by(id: params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    # employee = Employee.new
    # employee.save
    employee = Employee.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
    redirect_to employee_path(employee.id)
  end

  def edit
    @employee = Employee.find_by(id: params[:id])
    render :edit
  end

  def update
    @employee = Employee.find_by(id: params[:id])
    @employee.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
    redirect_to employee_path(@employee.id)
  end

  def destroy
    employee = Employee.find_by(id: params[:id])
    employee.destroy
    redirect_to employees_path
  end
end
