
map = new OpenLayers.Map 'map'
wms = new OpenLayers.Layer.WMS "OpenLayers WMS",
  "http://vmap0.tiles.osgeo.org/wms/vmap0", {layers: 'basic'}
map.addLayer wms


center_of_germany = new OpenLayers.LonLat 10.5, 51.5
berlin = new OpenLayers.LonLat 13.408056, 52.518611

map.setCenter center_of_germany,0

markers = new OpenLayers.Layer.Markers "Markers"
map.addLayer markers

size = new OpenLayers.Size 21,25
offset = new OpenLayers.Pixel -(size.w/2), -size.h
icon = new OpenLayers.Icon 'http://www.openlayers.org/dev/img/marker.png', size, offset
markers.addMarker new OpenLayers.Marker berlin,icon

map.zoomTo 7


