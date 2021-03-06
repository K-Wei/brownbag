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
    @events = @q.result(:distinct => true).includes(:user, :comments, :reservations, :restaurant, :commenters, :attendees).page(params[:page]).per(10)

    render("events/index.html.erb")
  end

  def show
    @reservation = Reservation.new
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
    @event.start_time = Chronic.parse(params[:start_time]).strftime("%l:%M %P")
    @event.end_time = Chronic.parse(params[:end_time]).strftime("%l:%M %P")
    @event.available = params[:available]
    @event.capacity_limit = params[:capacity_limit]
    @event.intent = params[:intent]

    save_status = @event.save

    if save_status == true

      @reservation = Reservation.new
      @reservation.user_id = current_user.id
      @reservation.event_id = @event.id
      @reservation.confirmed = true
      @reservation.host_approval = true
      @reservation.guest_approval = true
      @reservation.public_request = false
      @reservation.title = "You are hosting " + @event.title.to_s + " on " + @event.event_date.strftime("%D").to_s + " from " + @event.start_time.strftime("%l:%M %P").to_s + " to " + @event.end_time.strftime("%l:%M %P").to_s
      @reservation.description = @reservation.title.to_s + ". This reservation is automatically generated for you when you choose to host an event"
      @reservation.created_at = @event.created_at
      @reservation.updated_at = @event.updated_at

      @reservation.save

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
    @event.event_date = Chronic.parse(params[:event_date])
    @event.start_time = Chronic.parse(params[:start_time]).strftime("%l:%M %P")
    @event.end_time = Chronic.parse(params[:end_time]).strftime("%l:%M %P")
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
