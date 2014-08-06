library station;

import 'package:google_maps/google_maps.dart';
import 'package:transpori/model/model.dart';

part 'station_marker.dart';
part 'station_suggestion.dart';

class Station extends MapPoint {

  String id;
  StationMarker stationMarker;

  //TODO find alt
  @deprecated
  static final List types = [{
      "id": "BUS_STATION",
      "type": "BusStation"
    }, {
      "id": "TRAIN_STATION",
      "type": "TrainStation"
    }, {
      "id": "TRAMWAY_STATION",
      "type": "TramwayStation"
    }];

  Station(num lat, num lng, [String this.id]) : super(lat, lng);

  Station.fromLatLng(LatLng latLng, [String this.id]) : super(latLng.lat, latLng.lng);

  Station.fromMap(Map stationMap) : super(stationMap["latitude"], stationMap["longitude"]) {
    id = stationMap["id"];
  }

  factory Station.instanceFromMap(Map stationMap) {
    Station station;
    switch (stationMap["@type"]) {
      case "BusStation":
        station = new BusStation.instanceFromMap(stationMap);
        break;
      case "TrainStation":
        station = new TrainStation.instanceFromMap(stationMap);
        break;
      case "TramwayStation":
        station = new TramwayStation.instanceFromMap(stationMap);
        break;
    }
    return station;
  }
  
  bool get isNew => id == null;

  void syncLatLng() {
    lat = stationMarker.position.lat;
    lng = stationMarker.position.lng;
  }

  show(GMap map) {
    stationMarker.map = map;
  }

  hide() {
    stationMarker.map = null;
  }

  Map toJson() {
    Map json = super.toJson();
    json["id"] = id;
    return json;
  }

}

class BusStation extends Station {

  init() {
    stationMarker = new BusStationMarker(lat, lng, syncLatLng);
  }

  BusStation(num lat, num lng, [String id]) : super(lat, lng, id) {
    init();
  }
  
  BusStation.fromLatLng(LatLng latLng, [String id]) : super(latLng.lat, latLng.lng, id) {
    init();
  }

  BusStation.fromMap(Map busStationMap) : super.fromMap(busStationMap) {
    init();
  }

  factory BusStation.instanceFromMap(Map busStationMap) {
    return new BusStation.fromMap(busStationMap);
  }

}

class TrainStation extends Station {

  init() {
    stationMarker = new TrainStationMarker(lat, lng, syncLatLng);
  }

  TrainStation(num lat, num lng, [String id]) : super(lat, lng, id) {
    init();
  }
  
  TrainStation.fromLatLng(LatLng latLng, [String id]) : super(latLng.lat, latLng.lng, id) {
    init();
  }

  TrainStation.fromMap(Map trainStationMap) : super.fromMap(trainStationMap) {
    init();
  }

  factory TrainStation.instanceFromMap(Map trainStationMap) {
    return new TrainStation.fromMap(trainStationMap);
  }

}

class TramwayStation extends Station {

  init() {
    stationMarker = new TramwayStationMarker(lat, lng, syncLatLng);
  }

  TramwayStation(num lat, num lng, [String id]) : super(lat, lng, id) {
    init();
  }

  TramwayStation.fromLatLng(LatLng latLng, [String id]) : super(latLng.lat, latLng.lng, id) {
    init();
  }

  TramwayStation.fromMap(Map tramwayStationMap) : super.fromMap(tramwayStationMap) {
    init();
  }

  factory TramwayStation.instanceFromMap(Map tramwayStationMap) {
    return new TramwayStation.fromMap(tramwayStationMap);
  }

}
