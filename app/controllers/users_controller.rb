class UsersController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @hosted_count = @user.events_count
    @attended_count = @user.reservations_count - @hosted_count
  end

  def myevents

    @myevents = Reservation.where(:user_id => current_user.id)

  end
end
