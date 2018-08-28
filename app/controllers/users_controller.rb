class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def follow
    Follow.create(user: current_user, followed: User.find(params[:id]))
    redirect_to users_path
  end

  def unfollow
    Follow.where(user: current_user, followed: User.find(params[:id])).destroy_all
    redirect_to users_path
  end

end
