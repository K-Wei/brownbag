class ReservationsController < ApplicationController
  def index
    @user = current_user

    @q = Reservation.ransack(params[:q])

    # get list of public requests the current user has recieved (for self-hosted event)
    @recieved_pubrequests = Reservation.where(:event_id => Event.where(:user_id => current_user.id), :host_approval => false, :guest_approval => true, :public_request => true, :declined => false)

    # get list of reservations the current user has recieved (for non-hosted event)
    @recieved_privinvites = Reservation.where(:user_id => current_user.id, :host_approval => true, :guest_approval => false, :public_request => false, :declined => false)

    # get list of public requests the current user has sent (for non=hosted event)
    @pending_pubrequests = Reservation.where(:user_id => current_user.id, :host_approval => false, :guest_approval => true, :public_request => true, :declined => false)

    # get list of reservations the current user has sent (for self-hosted event)
    @pending_privreservations = Reservation.where(:event_id => Event.where(:user_id => current_user.id), :host_approval => true, :guest_approval => false, :public_request => false, :declined => false)

    @reservations = @q.result(:distinct => true).includes(:user, :event).page(params[:page]).per(10)

    render("reservations/index.html.erb")
  end

  def show
    @reservation = Reservation.find(params[:id])

    render("reservations/show.html.erb")
  end

  def new
    @reservation = Reservation.new

    render("reservations/new.html.erb")
  end

  def create
    @reservation = Reservation.new

    @reservation.user_id = params[:user_id]
    @reservation.event_id = params[:event_id]
    @reservation.confirmed = params[:confirmed]
    @reservation.host_approval = params[:host_approval]
    @reservation.guest_approval = params[:guest_approval]
    @reservation.public_request = params[:public_request]
    @reservation.title = params[:title]
    @reservation.description = params[:description]

    save_status = @reservation.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/reservations/new", "/create_reservation"
        redirect_to("/reservations")
      else
        redirect_back(:fallback_location => "/", :notice => "Reservation created successfully.")
      end
    else
      render("reservations/new.html.erb")
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])

    render("reservations/edit.html.erb")
  end

  def update
    @reservation = Reservation.find(params[:id])

    @reservation.user_id = params[:user_id]
    @reservation.event_id = params[:event_id]
    @reservation.confirmed = params[:confirmed]
    @reservation.host_approval = params[:host_approval]
    @reservation.guest_approval = params[:guest_approval]
    @reservation.public_request = params[:public_request]
    @reservation.title = params[:title]
    @reservation.description = params[:description]

    save_status = @reservation.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/reservations/#{@reservation.id}/edit", "/update_reservation"
        redirect_to("/reservations/#{@reservation.id}", :notice => "Reservation updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Reservation updated successfully.")
      end
    else
      render("reservations/edit.html.erb")
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])

    @reservation.destroy

    if URI(request.referer).path == "/reservations/#{@reservation.id}"
      redirect_to("/", :notice => "Reservation deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Reservation deleted.")
    end
  end
end
