part of model;

class MapPoint extends LatLngWrapper {

  MapPoint(num lat, num lng) : super(lat, lng);

  Map toJson() {
    Map json = new Map();
    json["@type"] = "MapPoint";
    json["latitude"] = lat.toString();
    json["longitude"] = lng.toString();
    return json;
  }

}

class LatLngWrapper {

  num _lat;
  num _lng;

  LatLngWrapper(this._lat, this._lng);

  set lat(lat) {
    _lat = lat;
  }
  get lat => _lat;

  set lng(lng) {
    _lng = lng;
  }
  get lng => _lng;

}