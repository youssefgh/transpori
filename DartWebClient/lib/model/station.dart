part of model;

class Station extends MapPoint {

  String id;

  Station(num lat, num lng, [String this.id]) : super(lat, lng);

  Station.fromMapPoint(MapPoint mapPoint, [String this.id]) : super(mapPoint.lat, mapPoint.lng);

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

  bool isNew() => id == null;

  bool isBusStation() => this is BusStation;
  bool isTrainStation() => this is TrainStation;
  bool isTramwayStation() => this is TramwayStation;

  Map toJson() {
    Map json = super.toJson();
    json["id"] = id;
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

class TrainStation extends Station {

  TrainStation(num lat, num lng, [String id]) : super(lat, lng, id) {
  }

  TrainStation.fromMapPoint(MapPoint mapPoint, [String id]) : super(mapPoint.lat, mapPoint.lng, id) {
  }

  TrainStation.fromMap(Map trainStationMap) : super.fromMap(trainStationMap) {
  }

  factory TrainStation.instanceFromMap(Map trainStationMap) {
    return new TrainStation.fromMap(trainStationMap);
  }

  Map toJson() {
    Map json = super.toJson();
    json["@type"] = "TrainStation";
    return json;
  }

}

class TramwayStation extends Station {

  TramwayStation(num lat, num lng, [String id]) : super(lat, lng, id) {
  }

  TramwayStation.fromMapPoint(MapPoint mapPoint, [String id]) : super(mapPoint.lat, mapPoint.lng, id) {
  }

  TramwayStation.fromMap(Map tramwayStationMap) : super.fromMap(tramwayStationMap) {
  }

  factory TramwayStation.instanceFromMap(Map tramwayStationMap) {
    return new TramwayStation.fromMap(tramwayStationMap);
  }

  Map toJson() {
    Map json = super.toJson();
    json["@type"] = "TramwayStation";
    return json;
  }

}
