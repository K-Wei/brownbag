class InvitationsController < ApplicationController
  def index
    @q = Invitation.ransack(params[:q])
    @invitations = @q.result(:distinct => true).includes(:user, :event).page(params[:page]).per(10)

    render("invitations/index.html.erb")
  end

  def show
    @invitation = Invitation.find(params[:id])

    render("invitations/show.html.erb")
  end

  def new
    @invitation = Invitation.new

    render("invitations/new.html.erb")
  end

  def create
    @invitation = Invitation.new

    @invitation.user_id = params[:user_id]
    @invitation.event_id = params[:event_id]
    @invitation.confirmed_reservation = params[:confirmed_reservation]
    @invitation.host_approval = params[:host_approval]
    @invitation.guest_approval = params[:guest_approval]
    @invitation.public_request = params[:public_request]
    @invitation.title = params[:title]
    @invitation.description = params[:description]

    save_status = @invitation.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/invitations/new", "/create_invitation"
        redirect_to("/invitations")
      else
        redirect_back(:fallback_location => "/", :notice => "Invitation created successfully.")
      end
    else
      render("invitations/new.html.erb")
    end
  end

  def edit
    @invitation = Invitation.find(params[:id])

    render("invitations/edit.html.erb")
  end

  def update
    @invitation = Invitation.find(params[:id])

    @invitation.user_id = params[:user_id]
    @invitation.event_id = params[:event_id]
    @invitation.confirmed_reservation = params[:confirmed_reservation]
    @invitation.host_approval = params[:host_approval]
    @invitation.guest_approval = params[:guest_approval]
    @invitation.public_request = params[:public_request]
    @invitation.title = params[:title]
    @invitation.description = params[:description]

    save_status = @invitation.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/invitations/#{@invitation.id}/edit", "/update_invitation"
        redirect_to("/invitations/#{@invitation.id}", :notice => "Invitation updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Invitation updated successfully.")
      end
    else
      render("invitations/edit.html.erb")
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])

    @invitation.destroy

    if URI(request.referer).path == "/invitations/#{@invitation.id}"
      redirect_to("/", :notice => "Invitation deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Invitation deleted.")
    end
  end
end
