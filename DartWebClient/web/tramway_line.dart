import 'dart:convert';
import 'package:google_maps/google_maps.dart';
import 'map_point.dart';
import 'station.dart';
import 'dart:collection';
import 'transportation_line.dart';

class TramwayLine extends TransportationLine {
  
  TramwayLine(GMap map) : super(map,new PolylineOptions()..strokeColor = "#2E64FE");
  
  TramwayLine.fromJSON(String json,GMap map) : super.fromJSON(json,map,new PolylineOptions()..strokeColor = "#2E64FE");

  TramwayLine.fromMap(Map tramwayLineMap,GMap map) : super.fromMap(tramwayLineMap, map,new PolylineOptions()..strokeColor = "#2E64FE");
}