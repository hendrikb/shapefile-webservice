require 'rgeo'
require 'rgeo-shapefile'
require 'pry'

class LatLonService



  def initialize shp_file
    @records = []
    RGeo::Shapefile::Reader.open(shp_file) do |file|
      file.each do |record|
        @records << record
      end
    end
  end


  def latlon2info lat, lon
    factory = ::RGeo::Cartesian.preferred_factory()
    point = factory.point lat, lon

    result = {}
    @records.each do |record|
      result = record if record.geometry.contains? point
    end

    convert_to_json result
  end




  private
  def convert_to_json result
    # TODO really convert to json here
    result.attributes
  end

end

