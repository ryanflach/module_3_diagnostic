class Station
  def initialize(params)
    @params = params
  end

  def self.service
    NrelService.new
  end

  def self.all(zip)
    stations_hash = service.nearest_10_elec_plg_stations(zip)
    stations_hash.map { |station| Station.new(station) }
  end

  def station_name
    params[:station_name]
  end

  def address
    "#{params[:street_address]}, " \
    "#{params[:city]}, #{params[:state]}, #{params[:zip]}"
  end

  def fuel_type_code
    params[:fuel_type_code]
  end

  def distance
    params[:distance]
  end

  def access_days_time
    params[:access_days_time]
  end

  private

  attr_reader :params
end
