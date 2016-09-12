class NrelService
  def initialize
    @connection =
      Faraday.new(
        'https://api.data.gov/nrel/alt-fuel-stations/v1/'
      ) do |build|
        build.adapter :net_http
        build.headers['X-Api-Key'] = ENV['NREL_KEY']
      end
  end

  def nearest_10_elec_plg_stations(zip)
    response = connection.get('nearest.json') do |req|
      req.params['location'] = zip
      req.params['radius'] = 6.0
      req.params['fuel_type'] = 'ELEC, LPG'
      req.params['limit'] = 10
    end
    parse(response)[:fuel_stations]
  end

  private

  attr_reader :connection

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
