Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "events#index"
  # Routes for the Restaurant resource:
  # CREATE
  get "/restaurants/new", :controller => "restaurants", :action => "new"
  post "/create_restaurant", :controller => "restaurants", :action => "create"

  # READ
  get "/restaurants", :controller => "restaurants", :action => "index"
  get "/restaurants/:id", :controller => "restaurants", :action => "show"

  # UPDATE
  get "/restaurants/:id/edit", :controller => "restaurants", :action => "edit"
  post "/update_restaurant/:id", :controller => "restaurants", :action => "update"

  # DELETE
  get "/delete_restaurant/:id", :controller => "restaurants", :action => "destroy"
  #------------------------------

  # Routes for the Comment resource:
  # CREATE
  get "/comments/new", :controller => "comments", :action => "new"
  post "/create_comment", :controller => "comments", :action => "create"

  # READ
  get "/comments", :controller => "comments", :action => "index"
  get "/comments/:id", :controller => "comments", :action => "show"

  # UPDATE
  get "/comments/:id/edit", :controller => "comments", :action => "edit"
  post "/update_comment/:id", :controller => "comments", :action => "update"

  # DELETE
  get "/delete_comment/:id", :controller => "comments", :action => "destroy"
  #------------------------------

  # Routes for the Event resource:
  # CREATE
  get "/events/new", :controller => "events", :action => "new"
  post "/create_event", :controller => "events", :action => "create"

  # READ
  get "/events", :controller => "events", :action => "index"
  get "/events/:id", :controller => "events", :action => "show"

  # UPDATE
  get "/events/:id/edit", :controller => "events", :action => "edit"
  post "/update_event/:id", :controller => "events", :action => "update"

  # DELETE
  get "/delete_event/:id", :controller => "events", :action => "destroy"
  #------------------------------

  # Routes for the Reservation resource:
  # CREATE
  get "/reservations/new", :controller => "reservations", :action => "new"
  post "/create_reservation", :controller => "reservations", :action => "create"

  # READ
  get "/reservations", :controller => "reservations", :action => "index"
  get "/reservations/:id", :controller => "reservations", :action => "show"

  # UPDATE
  get "/reservations/:id/edit", :controller => "reservations", :action => "edit"
  post "/update_reservation/:id", :controller => "reservations", :action => "update"

  # DELETE
  get "/delete_reservation/:id", :controller => "reservations", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"
  get "/myevents", :controller => "users", :action => "myevents"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
