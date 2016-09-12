class SearchController < ApplicationController
  def index
    @results = Station.all(params[:zip])
  end
end
