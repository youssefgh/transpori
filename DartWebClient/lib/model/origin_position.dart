part of model;

class OriginPosition extends MapPoint {

  Marker marker;
  OriginPosition(LatLng latLng, GMap map) : super.fromLatLng(latLng) {
    marker = new Marker()
        ..map = map
        ..position = latLng
        ..draggable = true
        ..onRightclick.listen((e) => hide())
        ..onDragend.listen((e) => syncLatLng())
        ..icon = "images/start.png";
  }

  show(CustomMap map) {
    marker.map = map;
  }

  hide() {
    marker.map = null;
  }

  syncLatLng() {
    lat = marker.position.lat;
    lng = marker.position.lng;
  }

  bool isVisible() {
    return marker.map != null;
  }

}
