import 'dart:convert';
import 'dart:async';
import 'package:google_maps/google_maps.dart';
//import 'package:json_object/json_object.dart';
import 'map_point.dart';
import 'station.dart';
import 'custom_map.dart';
import 'bus_line.dart';
import 'tramway_line.dart';
import 'train_line.dart';

class TransportationLine extends Polyline {
  String id;
  String name;
  InfoWindow infoWindow;

  static final List types = [{
      "id": "BUS_LINE",
      "type": "BusLine"
    }, {
      "id": "TRAIN_LINE",
      "type": "TrainLine"
    }, {
      "id": "TRAMWAY_LINE",
      "type": "TramwayLine"
    }];

  void init() {
    editable = true;
    onRightclick.listen((e) {
      for (int i = 0; i < path.length; i++) {
        if (e.latLng.equals(path.getAt(i))) {
          path.removeAt(i);
          break;
        }
      }
    });
    onMouseover.listen((e) {
      infoWindow = new InfoWindow()
          ..position = e.latLng
          ..content = name;
      infoWindow.open(map);
    });
    onMouseout.listen((e) {
      infoWindow.close();
    });
  }

  TransportationLine(PolylineOptions polylineOptions): super(polylineOptions) {
    init();
  }

  TransportationLine.fromJSON(String json, PolylineOptions polylineOptions): super(polylineOptions) {
    init();
    Map transportationLineMap = JSON.decode(json);
    id = transportationLineMap['id'];
    name = transportationLineMap['name'];
    if (transportationLineMap['mapPoints'] != null) {
      for (Map mapPointMap in transportationLineMap['mapPoints']) {
        if (mapPointMap['@type'] == "MapPoint") {
          //TODO export parse logic
          path.push(new MapPoint(mapPointMap['latitude'], mapPointMap['longitude']));
          continue;
        }
        if (mapPointMap['@type'] == "Station") {
          //TODO export parse logic
          path.push(new Station(mapPointMap['latitude'], mapPointMap['longitude']));
          continue;
        }
      }
    }
  }

  TransportationLine.fromMap(Map transportationLineMap, PolylineOptions polylineOptions): super(polylineOptions) {
    init();
    id = transportationLineMap['id'];
    name = transportationLineMap['name'];
    for (Map mapPointMap in transportationLineMap['mapPoints']) {
      if (mapPointMap['@type'] == "MapPoint") {
        //TODO export parse logic
        path.push(new MapPoint(mapPointMap['latitude'], mapPointMap['longitude']));
        continue;
      }
      if (mapPointMap['@type'] == "Station") {
        //TODO export parse logic
        path.push(new Station(mapPointMap['latitude'], mapPointMap['longitude']));
        continue;
      }
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

  void prepareForDelete() {
    print("bef"+map.toString());
    print(CustomMap.$wrap(map.$unsafe));
    CustomMap.$wrap(map.$unsafe).cancelOnClick();
    map = null;
  }
  
  MapPoint getClosestMapPoint(MapPoint mapPoint){
    List<LatLng> mapPoints = path.getArray();
    for(int i=0; i<mapPoints.length ; i++){
      if(mapPoints.elementAt(i).lat == mapPoint.lat && mapPoints.elementAt(i).lng == mapPoint.lng){
          return new MapPoint(mapPoints.elementAt(i).lat, mapPoints.elementAt(i).lng);
      }
    }
    return null;
  }

  Map toJson() {
    Map json = new Map();
    json["\"@type\""] = "\"" + runtimeType.toString() + "\"";
    if (id != null) json["\"id\""] = "\"" + id + "\"";
    json["\"name\""] = "\"" + name + "\"";
    List mapPoints = new List();
    MapPoint mapPoint;
    for (int i = 0; i < path.length; i++) {
      // TODO report and fix
      //mapPoints.add(JSON.encode(path.getAt(i)));
      //mapPoints.add("{\"@type\" : \"MapPoint\",\"latitude\":"+path.getAt(i).lat.toString()+", \"longitude\":"+path.getAt(i).lng.toString()+"}");
      mapPoint = new MapPoint(path.getAt(i).lat, path.getAt(i).lng);
      mapPoints.add(mapPoint.toJson().toString());
    }
    String s = "[";
    for (String mapPoint in mapPoints) {
      s += mapPoint + ",";
    }
    if (s.endsWith(",")) s = s.substring(0, s.length - 1);
    s += "]";
    json["\"mapPoints\""] = s;
    //print(json);
    return json;
  }
}
