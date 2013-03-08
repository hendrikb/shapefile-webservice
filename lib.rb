require 'rgeo'
require 'rgeo-shapefile'
require 'pry'
require 'json'

class LatLonService



  def initialize shp_file
    puts "setting up whole new data structure"
    @factory = ::RGeo::Cartesian.preferred_factory()
    @records = []
    RGeo::Shapefile::Reader.open(shp_file) do |file|
      file.each do |record|
        @records << record
      end
    end
    puts "done.... GO!"
  end


  def latlon2info lat, lon
    point = @factory.point lat, lon

    result = {}
    @records.each do |record|
      if record.geometry.contains? point
        result = record
        break
      end
    end

    convert_to_json result
  end




  private
  def convert_to_json result
    result.attributes.to_json
  end

end

