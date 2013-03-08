var berlin, center_of_germany, icon, map, markers, offset, size, wms;

map = new OpenLayers.Map('map');

wms = new OpenLayers.Layer.WMS("OpenLayers WMS", "http://vmap0.tiles.osgeo.org/wms/vmap0", {
  layers: 'basic'
});

map.addLayer(wms);

center_of_germany = new OpenLayers.LonLat(10.5, 51.5);

berlin = new OpenLayers.LonLat(13.408056, 52.518611);

map.setCenter(center_of_germany, 0);

markers = new OpenLayers.Layer.Markers("Markers");

map.addLayer(markers);

size = new OpenLayers.Size(21, 25);

offset = new OpenLayers.Pixel(-(size.w / 2), -size.h);

icon = new OpenLayers.Icon('http://www.openlayers.org/dev/img/marker.png', size, offset);

markers.addMarker(new OpenLayers.Marker(berlin, icon));

map.zoomTo(7);


OpenLayers.Control.Click = OpenLayers.Class(OpenLayers.Control, {
  defaultHandlerOptions: {
    'single': true,
    'double': false,
    'pixelTolerance': 0,
    'stopSingle': false,
    'stopDouble': false
  },

  initialize: function(options) {
    this.handlerOptions = OpenLayers.Util.extend(
      {}, this.defaultHandlerOptions
    );
    OpenLayers.Control.prototype.initialize.apply(
      this, arguments
    );
    this.handler = new OpenLayers.Handler.Click(
      this, {
      'click': this.trigger
    }, this.handlerOptions
    );
  },

  trigger: function(e) {
    var lonlat = map.getLonLatFromPixel(e.xy);
    alert("You clicked near " + lonlat.lat + " N, " +
          + lonlat.lon + " E");
  }

});



var click = new OpenLayers.Control.Click();
map.addControl(click);
click.activate();
