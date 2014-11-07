part of model;

class TransportationLine {

  String id;
  String name;
  ObservableList<MapPoint> mapPoints = new ObservableList();

  TransportationLine();

  TransportationLine.fromMap(Map transportationLineMap) {
    id = transportationLineMap['id'];
    name = transportationLineMap['name'];
    for (Map mapPointMap in transportationLineMap['mapPoints']) {
      MapPoint mapPoint = new MapPoint.instanceFromMap(mapPointMap);
      mapPoints.add(mapPoint);
    }
  }

  factory TransportationLine.instanceFromMap(Map transportationLineMap) {
    TransportationLine transportationLine;
    switch (transportationLineMap["@type"]) {
      case "BusLine":
        transportationLine = new BusLine.fromMap(transportationLineMap);
        break;
      case "TrainLine":
        transportationLine = new TrainLine.fromMap(transportationLineMap);
        break;
      case "TramwayLine":
        transportationLine = new TramwayLine.fromMap(transportationLineMap);
        break;
    }
    return transportationLine;
  }

  bool isNew() => id == null;

  reverseMapPoints() {
    mapPoints = new ObservableList.from(mapPoints.reversed);
  }

  double traveledDistance() {
    double traveledDistance = 0.0;
    for (int i = 0; i < mapPoints.length - 1; i++) {
      traveledDistance += mapPoints[i].distanceTo(mapPoints[i + 1]);
    }
    return traveledDistance;
  }

  bool isBusLine() => this is BusLine;
  bool isTrainLine() => this is TrainLine;
  bool isTramwayLine() => this is TramwayLine;

  Map toJson() {
    Map json = new Map();
    json["id"] = id;
    json["name"] = name;
    List<Map> mapPointMaps = new List();
    //TODO fix typing and remove
    //workaround
    mapPoints.forEach((mapPointElement) {
      if (mapPointElement is MapPoint) mapPointMaps.add(mapPointElement.toJson()); else {
        mapPointMaps.add(new MapPoint(mapPointElement.lat, mapPointElement.lng).toJson());
      }
    });
    /*
    mapPoints.forEach((MapPoint mapPointElement) {
      mapPointMaps.add(mapPointElement.toJson());
    });*/
    json["mapPoints"] = mapPointMaps;
    return json;
  }
  
}
