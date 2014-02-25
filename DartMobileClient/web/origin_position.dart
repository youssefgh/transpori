import 'package:google_maps/google_maps.dart';

class OriginPosition extends LatLng {

  Marker marker;
  OriginPosition(LatLng latLng, GMap map) : super(latLng.lat,latLng.lng){
    marker = new Marker()
      ..map = map
      ..position = new LatLng(lat, lng)
      ..onRightclick.listen((e){
        deleteMarker();
      })
      ..icon = "images/start.png";
  }
  
  void deleteMarker(){
    marker.visible = false;
    marker.map = null;
  }
  
  Map toJson(){
    Map json = new Map();
    //json["\"@type\""]= "\""+runtimeType.toString()+"\"";
    json["\"latitude\""]= lat;
    json["\"longitude\""]= lng;
    return json;
  }
}