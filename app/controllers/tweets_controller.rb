class TweetsController < ApplicationController

  def create
    @tweet = Tweet.new(secure_params.merge({user: current_user}))
    if @tweet.save
      flash[:notice] = "Tweeted!"
    else
      flash[:error] = "Error: #{@tweet.errors.messages}"
    end
    redirect_to root_path
  end

  private

  def secure_params
    params.require(:tweet).permit(:content)
  end


end
