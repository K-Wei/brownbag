Rails.application.routes.draw do
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

  # Routes for the Invitation resource:
  # CREATE
  get "/invitations/new", :controller => "invitations", :action => "new"
  post "/create_invitation", :controller => "invitations", :action => "create"

  # READ
  get "/invitations", :controller => "invitations", :action => "index"
  get "/invitations/:id", :controller => "invitations", :action => "show"

  # UPDATE
  get "/invitations/:id/edit", :controller => "invitations", :action => "edit"
  post "/update_invitation/:id", :controller => "invitations", :action => "update"

  # DELETE
  get "/delete_invitation/:id", :controller => "invitations", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
