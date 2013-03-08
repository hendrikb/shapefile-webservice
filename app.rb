# encoding: UTF-8

require 'coffee-script'
require 'rgeo'
require 'rgeo-shapefile'
require 'json'

require 'sinatra'
require './lib.rb'

set :haml, :format => :html5
SHAPE_FILE = 'data/post_pl.shp'
LATLON_SERVICE = LatLon::Service.new(SHAPE_FILE)

get '/' do
  haml :index
end

get '/app.js' do
  coffee :app
end



get '/lonlat2info/:lat/:lon' do
  begin
    convert_to_json LATLON_SERVICE.latlon2info params[:lon].to_f, params[:lat].to_f
  rescue LatLon::NoRecordFound
    {error: 'No Record found for that location'}.to_json
  end
end

def convert_to_json result
  begin result.attributes.to_json rescue {error: "Something went wrong with encoding... :)"}.to_json end
end

