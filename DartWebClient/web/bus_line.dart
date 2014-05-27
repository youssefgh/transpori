import 'dart:convert';
import 'package:google_maps/google_maps.dart';
import 'map_point.dart';
import 'station.dart';
import 'dart:collection';
import 'transportation_line.dart';

class BusLine extends TransportationLine {
  
  BusLine() : super(new PolylineOptions()..strokeColor = "#3ADF00");
  
  BusLine.fromJSON(String json) : super.fromJSON(json,new PolylineOptions()..strokeColor = "#3ADF00");

  BusLine.fromMap(Map busLineMap) : super.fromMap(busLineMap,new PolylineOptions()..strokeColor = "#3ADF00");
}