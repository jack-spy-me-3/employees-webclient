class EmployeesController < ApplicationController
  def show
    @employee = Unirest.get("http://localhost:3000/api/v2/employees/#{params[:id]}").body
    render "show.html.erb"
  end

  def index
    @employees = Unirest.get("http://localhost:3000/api/v2/employees").body
    render "index.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    employee = Unirest.post("http://localhost:3000/api/v2/employees",
                     headers:{ "Accept" => "application/json" }, 
                     parameters:{ first_name: params[:form_first_name],
                                  last_name: params[:form_last_name],
                                  email: params[:form_email] }
                          ).body
    redirect_to "/employees/#{employee['id']}"
  end
end
