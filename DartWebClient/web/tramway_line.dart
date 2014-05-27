import 'dart:convert';
import 'package:google_maps/google_maps.dart';
import 'map_point.dart';
import 'station.dart';
import 'dart:collection';
import 'transportation_line.dart';

class TramwayLine extends TransportationLine {
  
  TramwayLine() : super(new PolylineOptions()..strokeColor = "#2E64FE");
  
  TramwayLine.fromJSON(String json) : super.fromJSON(json, new PolylineOptions()..strokeColor = "#2E64FE");

  TramwayLine.fromMap(Map tramwayLineMap) : super.fromMap(tramwayLineMap, new PolylineOptions()..strokeColor = "#2E64FE");
}