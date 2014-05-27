import 'package:google_maps/google_maps.dart';
import 'package:json_object/json_object.dart';
import 'dart:collection';
import 'dart:async';

class MapPoint extends LatLng {
  
  num lat;
  num lng;
  
  MapPoint(lat, num lng) : super(lat,lng){
    this.lat = lat;
    this.lng = lng;
  }
  
  Map toJson(){
    Map json = new Map();
    json["\"@type\""]= "\""+runtimeType.toString()+"\"";
    json["\"latitude\""] = "\""+lat.toString()+"\"";
    json["\"longitude\""] = "\""+lng.toString()+"\"";
    return json;
  }
}