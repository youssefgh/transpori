part of transportation_line;

class TramwayLine extends TransportationLine {

  TramwayLine() : super(new PolylineOptions()..strokeColor = "#2E64FE");

  TramwayLine.fromMap(Map tramwayLineMap) : super.fromMap(tramwayLineMap, new PolylineOptions()..strokeColor = "#2E64FE");

}
