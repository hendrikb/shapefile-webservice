require 'coffee-script'
require 'rgeo'
require 'rgeo-shapefile'

require 'sinatra'
require './lib.rb'

set :haml, :format => :html5
LATLON_SERVICE = LatLon::Service.new('data/post_pl.shp')

get '/' do
  haml :index
end

get '/app.js' do
  coffee :app
end



get '/lonlat2info/:lat/:lon' do
  LATLON_SERVICE.latlon2info params[:lon].to_f, params[:lat].to_f
end

