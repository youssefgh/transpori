import 'dart:html';
import 'dart:js';
import 'dart:async';
import 'package:google_maps/google_maps.dart';
import 'station.dart';
import 'map_point.dart';
import 'transportation_line.dart';
import 'transportation_path.dart';
import 'transportation_response.dart';

class CustomMap extends GMap {

  List<Station> stations = new List();
  List<Station> stationSuggestions = new List();
  List<TransportationLine> transportationLines = new List();
  List<TransportationPath> transportationPaths = new List();
  StreamSubscription onClickStreamSubscription;

  static CustomMap $wrap(JsObject jsObject) => jsObject == null ? null : new CustomMap.fromJsObject(jsObject);
  CustomMap.fromJsObject(JsObject jsObject): super.fromJsObject(jsObject);

  CustomMap(Node mapDiv): super(mapDiv) {
    zoom = 9;
    center = new LatLng(33.55770396470521, -7.5963592529296875);
    mapTypeId = MapTypeId.ROADMAP;
    visualRefresh = true;
  }
  
  Station getNearestStation(MapPoint mapPoint){
    Station station = stations[0];
    num minDistance = stations[0].distanceTo(mapPoint);
    num tmpDistance;
    Station tmpStation;
    for(int i=1; i<stations.length; i++){
      tmpStation = stations[i];
      tmpDistance = tmpStation.distanceTo(mapPoint);
      if(tmpDistance < minDistance){
        station = tmpStation;
        minDistance = tmpDistance;
      }
    }
    return station;
  }

  void deleteStation(Station station) {
    stations.remove(station);
    station.prepareForDelete();
  }
  
  void deleteStationSuggestion(Station stationSuggestion) {
      stations.remove(stationSuggestion);
      stationSuggestion.prepareForDelete();
  }

  void clearStations() {
    for (Station station in stations) {
      station.prepareForDelete();
    }
  }

  void showStations() {
    for (Station station in stations) {
      station.marker.map = this;
    }
  }

  void hideStations() {
    for (Station station in stations) {
      station.hide();
    }
  }

  void showtransportationLines() {
    for (TransportationLine transportationLine in transportationLines) {
      transportationLine.show(this);
    }
  }

  void hidetransportationLines() {
    for (TransportationLine transportationLine in transportationLines) {
      transportationLine.hide();
    }
  }
  
  showTransportationPaths(){
    for(TransportationPath transportationPath in transportationPaths){
      transportationPath.show(this);
    }
  }
  
  HideTransportationPaths(){
    for(TransportationPath transportationPath in transportationPaths){
      transportationPath.hide();
    }
  }

  void clearTransportationPaths() {
    HideTransportationPaths();
    for (TransportationPath transportationPath in transportationPaths) {
      for (TransportationLine transportationLine in transportationPath.transportationLines) {
        transportationLine.map = null;
      }
    }
  }

  void cancelOnClick() {
    if (onClickStreamSubscription != null) {
      onClickStreamSubscription.cancel();
    }
  }
}
