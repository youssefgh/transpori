import 'package:google_maps/google_maps.dart';
import 'custom_map.dart';

class Destination extends LatLng {

  num lat;
  num lng;
  Marker marker;
  Destination(LatLng latLng, GMap map) : super(latLng.lat,latLng.lng){
    lat = latLng.lat;
    lng = latLng.lng;
    marker = new Marker()
      ..map = map
      ..position = new LatLng(lat, lng)
      ..draggable = true
      ..onRightclick.listen((e){
      hide();
      })
      ..onDragend.listen((e) => syncLatLng())
      ..icon = "images/finish.png";
  }
  
  void show(CustomMap map){
    marker.map = map;
  }
  
  void hide(){
    marker.map = null;
  }
  
  bool isVisible(){
    return marker.map != null;
  }

  void syncLatLng(){
    lat = marker.position.lat;
    lng = marker.position.lng;
  }

  Map toJson(){
    Map json = new Map();
    //json["\"@type\""]= "\""+runtimeType.toString()+"\"";
    json["\"latitude\""]= lat;
    json["\"longitude\""]= lng;
    return json;
  }
}