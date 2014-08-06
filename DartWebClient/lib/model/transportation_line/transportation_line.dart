library transportation_line;

import 'dart:async';
import 'package:google_maps/google_maps.dart';
import 'package:transpori/model/model.dart';
import 'package:transpori/model/station/station.dart';

part 'bus_line.dart';
part 'tramway_line.dart';
part 'train_line.dart';

class TransportationLine extends Polyline {
  String id;
  String name;
  List<MapPoint> mapPoints = new List();
  InfoWindow infoWindow;
  StreamSubscription<PolyMouseEvent> onRightclickStreamSubscription;

  //TODO find alt
  @deprecated
  static final List types = ["BUS_LINE", "TRAIN_LINE", "TRAMWAY_LINE"];

  void init() {
    /*
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
    path.onInsertAt.listen((i){
      mapPoints.add(new MapPoint.fromLatLng(path.getAt(i)));
    });
    path.onSetAt.listen((i){
      mapPoints[i.index] = new MapPoint.fromLatLng(path.getAt(i.index));
    });
    path.onRemoveAt.listen((i){
      mapPoints.removeAt(i.index);
    });
  }

  TransportationLine(PolylineOptions polylineOptions) : super(polylineOptions) {
    init();
  }

  TransportationLine.fromMap(Map transportationLineMap, PolylineOptions polylineOptions) : super(polylineOptions) {
    init();
    id = transportationLineMap['id'];
    name = transportationLineMap['name'];
    for (Map mapPointMap in transportationLineMap['mapPoints']) {
      MapPoint mapPoint = new MapPoint.instanceFromMap(mapPointMap);
      path.push(mapPoint);
      if(mapPoint is Station) mapPoints[mapPoints.length-1] = mapPoint;
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

  set editable(bool editable) {
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

  String get type => runtimeType.toString().replaceFirst("Line", "");

  bool get isNew => id == null;

  prepareForDelete() {
    CustomMap.$wrap(map.$unsafe).cancelOnClick();
    hide();
  }

  show(CustomMap map) {
    this.map = map;
  }

  showWithStations(CustomMap map) {
    show(map);
    showStations();
  }

  hide() {
    map = null;
  }

  hideWithStations() {
    hide();
    hideStations();
  }

  showStations() {
    mapPoints.forEach((MapPoint mapPointElement) {
      if (mapPointElement is Station) mapPointElement.show(map);
    });
  }

  hideStations() {
    mapPoints.forEach((MapPoint mapPointElement) {
      if (mapPointElement is Station) mapPointElement.hide();
    });
  }

  reverseMapPoints() {
    path = path.getArray().reversed.toList();
    mapPoints = mapPoints.reversed.toList();
  }

  double get traveledDistance {
    double traveledDistance = 0.0;
    for (int i = 0; i < mapPoints.length - 1; i++) {
      traveledDistance += mapPoints[i].distanceTo(mapPoints[i + 1]);
    }
    return traveledDistance;
  }

  Map toJson() {
    Map json = new Map();
    json["@type"] = runtimeType.toString();
    json["id"] = id;
    json["name"] = name;
    List<Map> mapPointMaps = new List();
    mapPoints.forEach((MapPoint mapPointElement) {
      mapPointMaps.add(mapPointElement.toJson());
    });
    json["mapPoints"] = mapPointMaps;
    return json;
  }
}
