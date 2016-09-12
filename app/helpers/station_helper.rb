module StationHelper
  def zip_code
    params[:zip]
  end

  def distance
    params[:distance] || 6
  end
end
