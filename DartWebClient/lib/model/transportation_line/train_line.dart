part of transportation_line;

class TrainLine extends TransportationLine {

  TrainLine() : super(new PolylineOptions()..strokeColor = "#FF4000");

  TrainLine.fromMap(Map trainLineMap) : super.fromMap(trainLineMap, new PolylineOptions()..strokeColor = "#FF4000");

}
