import 'package:google_maps/google_maps.dart';
import 'dart:collection';

class MapPoint extends LatLng {
  
  MapPoint(num lat, num lng) : super(lat,lng);
  
  Map toJson(){
    Map json = new Map();
    json["\"@type\""]= "\""+runtimeType.toString()+"\"";
    json["\"latitude\""] = "\""+lat.toString()+"\"";
    json["\"longitude\""] = "\""+lng.toString()+"\"";
    return json;
  }
}