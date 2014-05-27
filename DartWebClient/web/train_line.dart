import 'dart:convert';
import 'package:google_maps/google_maps.dart';
import 'map_point.dart';
import 'station.dart';
import 'dart:collection';
import 'transportation_line.dart';

class TrainLine extends TransportationLine {
  
  TrainLine() : super(new PolylineOptions()..strokeColor = "#FF4000");
  
  TrainLine.fromJSON(String json) : super.fromJSON(json, new PolylineOptions()..strokeColor = "#FF4000");

  TrainLine.fromMap(Map trainLineMap) : super.fromMap(trainLineMap, new PolylineOptions()..strokeColor = "#FF4000");
  
}