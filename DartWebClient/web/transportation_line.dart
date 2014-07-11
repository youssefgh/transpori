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

  static final List types = ["BUS_LINE", "TRAIN_LINE", "TRAMWAY_LINE"];

  void init() {/*
    onMouseover.listen((e) {
      if (infoWindow != null) infoWindow.close();
      infoWindow = new InfoWindow()
          ..position = e.latLng
          ..content = name;
      infoWindow.open(map);
    });
    onMouseout.listen((e) {
      infoWindow.close();
    });*/
  }

  TransportationLine(PolylineOptions polylineOptions) : super(polylineOptions) {
    init();
  }

  //FIXME
  //TODO review for redundancy
  //DEPRECATED
  TransportationLine.fromJSON(String json, PolylineOptions polylineOptions) : super(polylineOptions) {
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

  //TODO export logic to MapPoint or Station
  TransportationLine.fromMap(Map transportationLineMap, PolylineOptions polylineOptions) : super(polylineOptions) {
    init();
    id = transportationLineMap['id'];
    name = transportationLineMap['name'];
    for (Map mapPointMap in transportationLineMap['mapPoints']) {
      if (mapPointMap['@type'] == "MapPoint") {
        //TODO export parse logic
        path.push(new MapPoint(mapPointMap['latitude'], mapPointMap['longitude']));
        mapPoints.add(new MapPoint(mapPointMap['latitude'], mapPointMap['longitude']));
        continue;
      }
      if (mapPointMap['@type'] == "BusStation") {
        //TODO export parse logic
        path.push(new BusStation(mapPointMap['latitude'], mapPointMap['longitude']));
        mapPoints.add(new BusStation(mapPointMap['latitude'], mapPointMap['longitude'])..id = mapPointMap['id']);
        continue;
      }
      if (mapPointMap['@type'] == "TrainStation") {
        //TODO export parse logic
        path.push(new TrainStation(mapPointMap['latitude'], mapPointMap['longitude']));
        mapPoints.add(new TrainStation(mapPointMap['latitude'], mapPointMap['longitude'])..id = mapPointMap['id']);
        continue;
      }
      if (mapPointMap['@type'] == "TramwayStation") {
        //TODO export parse logic
        path.push(new TramwayStation(mapPointMap['latitude'], mapPointMap['longitude']));
        mapPoints.add(new TramwayStation(mapPointMap['latitude'], mapPointMap['longitude'])..id = mapPointMap['id']);
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

  StreamSubscription<PolyMouseEvent> onRightclickStreamSubscription;

  void set editable(bool editable) {
    super.editable = editable;
    if (onRightclickStreamSubscription != null) onRightclickStreamSubscription.cancel();
    if (editable) {
      onRightclickStreamSubscription = onRightclick.listen((e) {
        for (int i = 0; i < path.length; i++) {
          if (e.latLng.equals(path.getAt(i))) {
            path.removeAt(i);
            break;
          }
        }
      });
    }
  }

  bool isNew() {
    return id == null;
  }

  void prepareForDelete() {
    CustomMap.$wrap(map.$unsafe).cancelOnClick();
    hide();
  }

  show(CustomMap map) {
    this.map = map;
  }

  hide() {
    map = null;
  }

  MapPoint getClosestMapPoint(MapPoint mapPoint) {
    List<LatLng> mapPoints = path.getArray();
    for (int i = 0; i < mapPoints.length; i++) {
      if (mapPoints.elementAt(i).lat == mapPoint.lat && mapPoints.elementAt(i).lng == mapPoint.lng) {
        return new MapPoint(mapPoints.elementAt(i).lat, mapPoints.elementAt(i).lng);
      }
    }
    return null;
  }
  //TODO optimize
  int indexOf(MapPoint mapPoint) {
    /*
    path.forEach((latLng,i){
      if(latLng.equals(mapPoint)) return i; 
    });*/
    List<LatLng> mapPoints = path.getArray();
    for (int i = 0; i < mapPoints.length; i++) {
      if (mapPoints.elementAt(i).lat == mapPoint.lat && mapPoints.elementAt(i).lng == mapPoint.lng) {
        return i;
      }
    }
    return -1;
  }

  String get type => runtimeType.toString().replaceFirst("Line", "");

  List<MapPoint> mapPoints = new List();

  showStations() {
    for (MapPoint mapPoint in mapPoints) {
      if (mapPoint is Station) {
        mapPoint.show(map);
      }
    }
  }

  hideStations() {
    for (MapPoint mapPoint in mapPoints) {
      if (mapPoint is Station) {
        mapPoint.hide();
      }
    }
  }

  void reverseMapPoints() {
    path = path.getArray().reversed.toList();
  }
  
  double get traveledDistance{
    double traveledDistance = 0.0;
    for(int i = 0; i<mapPoints.length - 1;i++){
      traveledDistance += mapPoints[i].distanceTo(mapPoints[i+1]);
    }
    return traveledDistance;
  }

  Map toJson() {
    Map json = new Map();
    json["\"@type\""] = "\"" + runtimeType.toString() + "\"";
    if (id != null) json["\"id\""] = "\"" + id + "\"";
    if (name != null) json["\"name\""] = "\"" + name + "\""; else json["\"name\""] = "\"\"";
    List mapPoints = new List();
    MapPoint mapPoint;
    for (int i = 0; i < path.length; i++) {
      // TODO fix
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
    return json;
  }
}
