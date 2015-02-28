library station;

import 'package:transpori_mobile/model/model.dart';

class Station extends MapPoint {

  String id;
  String name;

  Station(num lat, num lng, [String this.id, String this.name]) : super(lat, lng);

  Station.fromMapPoint(MapPoint mapPoint, [String this.id, String this.name]) : super(mapPoint.lat, mapPoint.lng);

  Station.fromMap(Map stationMap) : super(stationMap["latitude"], stationMap["longitude"]) {
    id = stationMap["id"];
    name = stationMap["name"];
  }

  Map toJson() {
    Map json = super.toJson();
    json["id"] = id;
    json["name"] = name;
    return json;
  }

}

class BusStation extends Station {

  BusStation(num lat, num lng, [String id]) : super(lat, lng, id) {
  }

  BusStation.fromMapPoint(MapPoint mapPoint, [String id]) : super(mapPoint.lat, mapPoint.lng, id) {
  }

  BusStation.fromMap(Map busStationMap) : super.fromMap(busStationMap) {
  }

  factory BusStation.instanceFromMap(Map busStationMap) {
    return new BusStation.fromMap(busStationMap);
  }

  Map toJson() {
    Map json = super.toJson();
    json["@type"] = "BusStation";
    return json;
  }

}