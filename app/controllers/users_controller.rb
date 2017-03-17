class UsersController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @hosted_count = @user.events_count
    if @hosted_count == nil
       @hosted_count = 0
     end
    if @user.reservations_count == nil
       @user.reservations_count = 0
    end
    @attended_count = @user.reservations_count - @hosted_count
  end

  def myevents

    @myevents = Reservation.where(:user_id => current_user.id)

  end
end
