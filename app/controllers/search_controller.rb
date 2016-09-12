class SearchController < ApplicationController
  def index
    @stations = Station.all(params[:zip])
  end

  private

  # def formatted_params
  #   hash = { zip: params[:zip].to_i }
  #   if params[:distance] = "Distance...(optional)"
  #     hash[:distance] = 6
  #   else
  #     hash[:distance] = params[:distance].to_i
  #   end
  #   hash
  # end
end
