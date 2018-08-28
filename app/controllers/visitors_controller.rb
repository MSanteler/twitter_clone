class VisitorsController < ApplicationController

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all
  end

end
