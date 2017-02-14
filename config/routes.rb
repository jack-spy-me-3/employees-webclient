Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/employees/new", to: "employees#new"
  post "/employees", to: "employees#create"
  get "/employees", to: "employees#index"
  get "/employees/:id", to: "employees#show"
end
