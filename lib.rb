require 'rgeo'
require 'rgeo-shapefile'
require 'pry'

class Converter

  def self.latlon2info lat, lon
    result = query_file lat, lon

    if result.nil? then return {} end

    convert_to_json result
  end


  private
  def self.convert_to_json result
    result.attributes
  end

  def self.query_file lat, lon
    factory = ::RGeo::Cartesian.preferred_factory()
    point = factory.point lat, lon

    RGeo::Shapefile::Reader.open('data/post_pl.shp') do |file|
      # puts "File contains #{file.num_records} records."
      file.each do |record|
        return record if record.geometry.contains? point
      end
    end
  end
end

