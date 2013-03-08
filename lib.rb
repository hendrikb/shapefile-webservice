# encoding: UTF-8
require 'rgeo'
require 'rgeo-shapefile'
require 'pry'

module LatLon
  class Service
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

      @records.each do |record|
        if record.geometry.contains? point
          return record
        end
      end
      raise NoRecordFound
    end

  end
  class NoRecordFound < Exception ; end
end
