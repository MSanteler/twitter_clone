class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:query]
      @query_text = ""
    else
      @users = User.all
    end
  end

  def show
    # sets @user for use in the view
    user_from_params
  end

  def follow
    if current_user.follow(user_from_params)
      redirect_to users_path, :notice => "Followed #{user_from_params.name}"
    else
      redirect_to users_path, :alert => "Error: You cannot follow yourself"
    end
  end

  def unfollow
    if current_user.unfollow(user_from_params)
      redirect_to users_path, :notice => "Unfollowed #{user_from_params.name}"
    else
      redirect_to users_path, :alert => "Something went wrong"
    end
  end

  private

  def user_from_params
    @user ||= User.find(params[:id])
  end
end
