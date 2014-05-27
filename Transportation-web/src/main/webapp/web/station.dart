import 'package:google_maps/google_maps.dart';
//import 'package:json_object/json_object.dart';
import 'dart:convert';
import 'map_point.dart';

class Station extends MapPoint {
  
  String id;
  Marker marker;
  
  Station(num lat, num lng, GMap map, [String id]) : super(lat,lng){
    this.id = id;
    marker = new Marker()
      ..map = map
      ..position = new LatLng(lat, lng)
      ..onRightclick.listen((e){
        deleteMarker();
      })
      ;
  }
  
  void deleteMarker(){/*
    HttpRequest httpRequest = new HttpRequest()
      ..open("DELETE", "http://localhost:8080/Transportation-web/rest/Station/"+id)
      ..setRequestHeader('content-type', 'application/json')
      ..send()
      ;*/
    marker.map = null;
    marker.visible = false;
    //marker = null;
  }
  
  Map toJson(){
    //JsonObject json = new JsonObject();
    Map json = new Map();
    json["@type"] = runtimeType.toString();
    if(id!=null)
      json["id"] = id;
    json["latitude"] = lat;
    json["longitude"] = lng;
    return json;
  }
  
}

class BusStation extends Station {
  BusStation(num lat, num lng, GMap map, [String id]) : super(lat,lng,map,id){
    Icon icon = new Icon();
    icon.url = "images/bus_station.png";
    //icon.size = new Size(22,22);
    marker.icon = icon;
  }
}

class TrainStation extends Station {
  TrainStation(num lat, num lng, GMap map, [String id]) : super(lat,lng,map,id){
    Icon icon = new Icon();
    icon.url = "images/train_station.png";
    marker.icon = icon;
  }
}

class TramwayStation extends Station {
  TramwayStation(num lat, num lng, GMap map, [String id]) : super(lat,lng,map,id){
    Icon icon = new Icon();
    icon.url = "images/tramway_station.png";
    marker.icon = icon;
  }
}