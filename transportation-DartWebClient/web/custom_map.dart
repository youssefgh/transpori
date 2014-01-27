import 'dart:html';
import 'package:google_maps/google_maps.dart';
import 'origin_position.dart';
import 'destination.dart';
import 'station.dart';
import 'transportation_line.dart';

class CustomMap extends GMap {
  OriginPosition originPosition;
  Destination destination;
  List<Station> stations = new List();
  TransportationLine selectedTransportationLine;
  List<TransportationLine> transportationLines = new List();
  CustomMap(Node mapDiv) : super(mapDiv){
    zoom = 11;
    center = new LatLng(33.55770396470521, -7.5963592529296875);
    mapTypeId = MapTypeId.ROADMAP;
  }
  /*
  void createStation(num lat, num lng,[String id]){
    Station station = new Station(lat, lng, this)..id = id;
    stations.add(station);
    station.marker.onRightclick.listen((e){
      for(num i = 0;i<stations.length;i++){
        if(stations.elementAt(i).equals(station)){
          stations.elementAt(i).deleteMarker();
          break;
        }
      }
    });
  }*/
  
  void deleteStations(){
    for(Station station in stations){
      station.deleteMarker();
    }
    stations = new List();
  }
  
  void showStations(){
    for(Station station in stations){
      station.marker.map = this;
    }
  }
  
  void hideStations(){
    for(Station station in stations){
      station.marker.map = null;
    }
  }
}