part of model;

class Destination extends MapPoint {

  Marker marker;
  Destination(LatLng latLng, GMap map) : super.fromLatLng(latLng) {
    marker = new Marker()
        ..map = map
        ..position = latLng
        ..draggable = true
        ..onRightclick.listen((e) => hide())
        ..onDragend.listen((e) => syncLatLng())
        ..icon = "images/finish.png";
  }

  show(CustomMap map) {
    marker.map = map;
  }

  hide() {
    marker.map = null;
  }

  bool isVisible() {
    return marker.map != null;
  }

  syncLatLng() {
    lat = marker.position.lat;
    lng = marker.position.lng;
  }

}
