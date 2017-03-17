class ReservationsController < ApplicationController

  before_action :restrict_authuser, :only => [:edit, :update, :destroy, :show]

  def index
    @user = current_user

    # @q = Reservation.ransack(params[:q])

    @reservations = Reservation.where(:declined => false)

    reservationquery1 = @reservations.where(:event_id => Event.where(:user_id => current_user.id).pluck(:id))
    reservationquery2 = @reservations.where(:user_id => current_user.id)

    # get list of public requests the current user has recieved and needs to approve (for self-hosted event)
    @recieved_pubrequests = reservationquery1.where(:host_approval => false, :guest_approval => true, :public_request => true)

    # get list of reservations the current user has recieved and needs to accept (for non-hosted event)
    @recieved_privinvites = reservationquery2.where(:host_approval => true, :guest_approval => false, :public_request => false)

    @sent_pending = @reservataions.where(:confirmed => false)

    # Not sure whether I want to keep these or not. Saving here just in case
    # # get list of public requests the current user has sent and are pending (for non=hosted event)
    # @pending_pubrequests = reservationquery2.where(:host_approval => false, :guest_approval => true, :public_request => true)
    #
    # # get list of reservations the current user has sent and are pending (for self-hosted event)
    # @pending_privreservations = reservationquery1.where(:host_approval => true, :guest_approval => false, :public_request => false)

    @attendances = Reservation.where(:confirmed => true)

    # @reservations = @q.result(:distinct => true).includes(:user, :event).page(params[:page]).per(10)

    render("reservations/index.html.erb")
  end

  def show

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


    render("reservations/edit.html.erb")
  end

  def update

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

    @reservation.destroy

    if URI(request.referer).path == "/reservations/#{@reservation.id}"
      redirect_to("/", :notice => "Reservation deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Reservation deleted.")
    end
  end

  def restrict_authuser

    @reservation = Reservation.find(params[:id])

    if current_user != @reservation.user or current_user != @reservation.event
        redirect_to("/", :notice => "Nice try.")
    end

  end

end
