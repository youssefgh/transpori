part of transportation_line;

class BusLine extends TransportationLine {

  BusLine() : super(new PolylineOptions()..strokeColor = "#3ADF00");

  BusLine.fromMap(Map busLineMap) : super.fromMap(busLineMap, new PolylineOptions()..strokeColor = "#3ADF00");

}
