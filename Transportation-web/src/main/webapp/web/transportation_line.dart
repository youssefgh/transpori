import 'dart:convert';
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
  
  void init(GMap map){
    super.map = map;
    editable = true;
    onRightclick.listen((e) {
      for(int i = 0;i<path.length;i++){
        if(e.latLng.equals(path.getAt(i))){
          path.removeAt(i);
          break;
        }
      }
    });
  }
  
  TransportationLine(GMap map,PolylineOptions polylineOptions) : super(polylineOptions) {
    init(map);
  }
  
  TransportationLine.fromJSON(String json,GMap map,PolylineOptions polylineOptions) : super(polylineOptions) {
    init(map);
    Map transportationLineMap = JSON.decode(json);
    id = transportationLineMap['id'];
    name = transportationLineMap['name'];
    if(transportationLineMap['mapPoints'] != null)
    for(Map mapPointMap in transportationLineMap['mapPoints']){
      if(mapPointMap['@type']=="MapPoint"){
        path.push(new MapPoint(mapPointMap['latitude'],mapPointMap['longitude']));
        continue;
      }
      if(mapPointMap['@type']=="Station"){
        path.push(new Station(mapPointMap['latitude'],mapPointMap['longitude'],map));
        continue;
      }
    }
  }

  TransportationLine.fromMap(Map transportationLineMap,GMap map,PolylineOptions polylineOptions) : super(polylineOptions) {
    init(map);
    id = transportationLineMap['id'];
    name = transportationLineMap['name'];
    if(transportationLineMap['mapPoints'] != null)
    for(Map mapPointMap in transportationLineMap['mapPoints']){
      if(mapPointMap['@type']=="MapPoint"){
        path.push(new MapPoint(mapPointMap['latitude'],mapPointMap['longitude']));
        continue;
      }
      if(mapPointMap['@type']=="Station"){
        path.push(new Station(mapPointMap['latitude'],mapPointMap['longitude'],map));
        continue;
      }
    }
  }
  
  factory TransportationLine.instanceFromMap(Map transportationLineMap,GMap map) {
    TransportationLine transportationLine;
    switch (transportationLineMap["@type"]){
      case "BusLine" :
        transportationLine = new BusLine.fromMap(transportationLineMap,map);   
        break;
      case "TrainLine" :
        transportationLine = new TrainLine.fromMap(transportationLineMap,map);   
        break;
      case "TramwayLine" :
        transportationLine = new TramwayLine.fromMap(transportationLineMap,map);   
        break;
    }
    return transportationLine;
  }
  
  Map toJson(){
    Map json = new Map();
    json["\"@type\""]= "\""+runtimeType.toString()+"\"";
    if(id != null)
      json["\"id\""]= "\""+id+"\"";
    json["\"name\""]= "\""+name+"\"";
    List mapPoints = new List();
    MapPoint mapPoint;
    for(int i=0;i<path.length;i++){
      // TODO report and fix
      //mapPoints.add(JSON.encode(path.getAt(i)));
      //mapPoints.add("{\"@type\" : \"MapPoint\",\"latitude\":"+path.getAt(i).lat.toString()+", \"longitude\":"+path.getAt(i).lng.toString()+"}");
      mapPoint = new MapPoint(path.getAt(i).lat, path.getAt(i).lng);
      mapPoints.add(mapPoint.toJson().toString());
    }
    String s ="[";
    for(String mapPoint in mapPoints){
      s +=  mapPoint+",";
    }
    if(s.endsWith(","))
      s = s.substring(0, s.length-1);
    s +="]";
    json["\"mapPoints\""] = s;
    //print(json);
    return json;
  }
}