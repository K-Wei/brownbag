class EventsController < ApplicationController
  before_action :current_user_must_be_event_user, :only => [:edit, :update, :destroy]
  skip_before_action :authenticate_user!, :only => [:index, :show]

  def current_user_must_be_event_user
    event = Event.find(params[:id])

    unless current_user == event.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = Event.ransack(params[:q])
    @events = @q.result(:distinct => true).includes(:user, :comments, :invitations, :restaurant, :commenters, :attendees).page(params[:page]).per(10)

    render("events/index.html.erb")
  end

  def show
    @invitation = Invitation.new
    @comment = Comment.new
    @event = Event.find(params[:id])

    render("events/show.html.erb")
  end

  def new
    @user = current_user
    @event = Event.new

    render("events/new.html.erb")
  end

  def create
    @event = Event.new

    @event.user_id = params[:user_id]
    @event.restaurant_id = params[:restaurant_id]
    @event.host = params[:host]
    @event.title = params[:title]
    @event.description = params[:description]
    @event.event_date = Chronic.parse(params[:event_date])
    @event.start_time = params[:start_time]
    @event.end_time = params[:end_time]
    @event.available = params[:available]
    @event.capacity_limit = params[:capacity_limit]
    @event.intent = params[:intent]

    save_status = @event.save

    if save_status == true

      @invitation = Invitation.new
      @invitation.user_id = current_user.id
      @invitation.event_id = @event.id
      @invitation.confirmed = true
      @invitation.host_approval = true
      @invitation.guest_approval = true
      @invitation.public_request = false
      @invitation.title = @event.title.to_s + " (event_id: " + @event.id.to_s + " ) " + "reservation for Host("+ @event.host.to_s + ") / User_id(" + @current_user.id.to_s + ")"
      @invitation.description = @invitation.title.to_s + ". This is the default invitation automatically generated for a host when an event is created"
      @invitation.created_at = @event.created_at
      @invitation.updated_at = @event.updated_at

      @invitation.save

      referer = URI(request.referer).path

      case referer
      when "/events/new", "/create_event"
        redirect_to("/events")
      else
        redirect_back(:fallback_location => "/", :notice => "Event created successfully.")
      end
    else
      render("events/new.html.erb")
    end
  end

  def edit
    @event = Event.find(params[:id])

    render("events/edit.html.erb")
  end

  def update
    @event = Event.find(params[:id])
    @event.restaurant_id = params[:restaurant_id]
    @event.host = params[:host]
    @event.title = params[:title]
    @event.description = params[:description]
    @event.event_date = params[:event_date]
    @event.start_time = params[:start_time]
    @event.end_time = params[:end_time]
    @event.available = params[:available]
    @event.capacity_limit = params[:capacity_limit]
    @event.intent = params[:intent]

    save_status = @event.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/events/#{@event.id}/edit", "/update_event"
        redirect_to("/events/#{@event.id}", :notice => "Event updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Event updated successfully.")
      end
    else
      render("events/edit.html.erb")
    end
  end

  def destroy
    @event = Event.find(params[:id])

    @event.destroy

    if URI(request.referer).path == "/events/#{@event.id}"
      redirect_to("/", :notice => "Event deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Event deleted.")
    end
  end
end
