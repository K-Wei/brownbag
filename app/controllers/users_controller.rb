class UsersController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def myevents

    @myattendedevents = Invitation.where(:user_id => current_user.id)

  end
end
