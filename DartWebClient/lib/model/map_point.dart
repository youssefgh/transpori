part of model;

class MapPoint extends LatLng {

  num lat;
  num lng;

  static MapPoint $wrap(JsObject jsObject) => jsObject == null ? null : new MapPoint.fromJsObject(jsObject);
  MapPoint.fromJsObject(JsObject jsObject) : super.fromJsObject(jsObject);

  MapPoint(num lat, num lng) : super(lat, lng) {
    this.lat = lat;
    this.lng = lng;
  }

  MapPoint.fromLatLng(LatLng latLng) : super(latLng.lat, latLng.lng) {
    this.lat = latLng.lat;
    this.lng = latLng.lng;
  }

  MapPoint.fromMap(Map mapPointMap) : super(mapPointMap["latitude"], mapPointMap["longitude"]);

  factory MapPoint.instanceFromMap(Map mapPointMap) {
    MapPoint mapPoint;
    switch (mapPointMap["@type"]) {
      case "MapPoint":
        mapPoint = new MapPoint.fromMap(mapPointMap);
        break;
      default:
        mapPoint = new Station.instanceFromMap(mapPointMap);
    }
    return mapPoint;
  }

  num distanceTo(MapPoint mapPoint) {
    final num radius = 6371;
    num dLatitude = toRadians(mapPoint.lat - lat);
    num dLongitude = toRadians(mapPoint.lng - lng);
    num latitude1 = toRadians(lat);
    num latitude2 = toRadians(mapPoint.lat);
    num haversine = sin(dLatitude / 2) * sin(dLatitude / 2) + sin(dLongitude / 2) * sin(dLongitude / 2) * cos(latitude1) * cos(latitude2);
    num c = 2 * atan2(sqrt(haversine), sqrt(1 - haversine));
    return radius * c * 1000;
  }

  num toRadians(num deg) => deg * (PI / 180);
  
  bool equals(LatLng latLng) {
    return lat == latLng.lat && lng == latLng.lng;
  }

  Map toJson() {
    Map json = new Map();
    json["@type"] = runtimeType.toString();
    json["latitude"] = lat.toString();
    json["longitude"] = lng.toString();
    return json;
  }

}
