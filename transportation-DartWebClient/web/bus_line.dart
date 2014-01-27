import 'dart:convert';
import 'package:google_maps/google_maps.dart';
import 'map_point.dart';
import 'station.dart';
import 'dart:collection';
import 'transportation_line.dart';

class BusLine extends TransportationLine {
  
  BusLine(GMap map) : super(map,new PolylineOptions()..strokeColor = "#3ADF00");
  
  BusLine.fromJSON(String json,GMap map) : super.fromJSON(json,map,new PolylineOptions()..strokeColor = "#3ADF00");

  BusLine.fromMap(Map busLineMap,GMap map) : super.fromMap(busLineMap, map,new PolylineOptions()..strokeColor = "#3ADF00");
}