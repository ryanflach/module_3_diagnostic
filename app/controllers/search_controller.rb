class SearchController < ApplicationController
  def index
    connection = Faraday.new('https://api.data.gov/nrel/alt-fuel-stations/v1/nearest.json') do |build|
      build.adapter :net_http
      build.headers['X-Api-Key'] = ENV['NREL_KEY']
    end
    response = connection.get do |req|
      req.params['location'] = params[:q]
      req.params['radius'] = 6.0
      req.params['fuel_type'] = 'ELEC, LPG'
      req.params['limit'] = 10
    end
    @results = JSON.parse(response.body, symbolize_names: true)[:fuel_stations]
    byebug
  end
end
