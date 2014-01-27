import 'dart:convert';
import 'package:google_maps/google_maps.dart';
import 'map_point.dart';
import 'station.dart';
import 'dart:collection';
import 'transportation_line.dart';

class TrainLine extends TransportationLine {
  
  TrainLine(GMap map) : super(map,new PolylineOptions()..strokeColor = "#FF4000");
  
  TrainLine.fromJSON(String json,GMap map) : super(map,new PolylineOptions()..strokeColor = "#FF4000");

  TrainLine.fromMap(Map trainLineMap,GMap map) : super(map,new PolylineOptions()..strokeColor = "#FF4000");
  
}