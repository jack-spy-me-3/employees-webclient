class EmployeesController < ApplicationController
  def show
    @employee = Unirest.get("#{ENV['API_URL']}employees/#{params[:id]}").body
    render "show.html.erb"
  end

  def index
    @employees = Unirest.get("#{ENV['API_URL']}employees").body
    render "index.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    employee = Unirest.post("#{ENV['API_URL']}employees",
                     headers:{ "Accept" => "application/json" }, 
                     parameters:{ first_name: params[:form_first_name],
                                  last_name: params[:form_last_name],
                                  email: params[:form_email] }
                          ).body
    redirect_to "/employees/#{employee['id']}"
  end

  def edit
    @employee = Unirest.get("#{ENV['API_URL']}employees/#{params[:id]}").body
    render "edit.html.erb"
  end

  def update
    @employee = Unirest.patch("#{ENV['API_URL']}employees/#{params[:id]}",
                     headers:{ "Accept" => "application/json" }, 
                     parameters:{ first_name: params[:first_name],
                                  last_name: params[:last_name],
                                  email: params[:email] }
                          ).body
    redirect_to "/employees/#{@employee['id']}"
  end

  def destroy
    Unirest.delete("#{ENV['API_URL']}employees/#{params[:id]}").body
    redirect_to "/employees"
  end
end
