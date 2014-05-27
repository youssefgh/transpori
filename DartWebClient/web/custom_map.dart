import 'dart:html';
import 'dart:js';
import 'dart:async';
import 'package:google_maps/google_maps.dart';
import 'station.dart';
import 'transportation_line.dart';
import 'transportation_path.dart';
import 'transportation_response.dart';

class CustomMap extends GMap {

  List<Station> stations = new List();
  List<Station> stationSuggestions = new List();
  List<TransportationLine> transportationLines = new List();
  List<TransportationPath> suggestions = new List();
  StreamSubscription onClickStreamSubscription;

  static CustomMap $wrap(JsObject jsObject) => jsObject == null ? null : new CustomMap.fromJsObject(jsObject);
  CustomMap.fromJsObject(JsObject jsObject): super.fromJsObject(jsObject);

  CustomMap(Node mapDiv): super(mapDiv) {
    zoom = 11;
    center = new LatLng(33.55770396470521, -7.5963592529296875);
    mapTypeId = MapTypeId.ROADMAP;
    visualRefresh = true;
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
      transportationLine.map = this;
    }
  }

  void hidetransportationLines() {
    for (TransportationLine transportationLine in transportationLines) {
      transportationLine.map = null;
    }
  }

  void clearSuggestions() {
    for (TransportationPath transportationPath in suggestions) {
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
