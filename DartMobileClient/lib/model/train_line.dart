part of model;

class TrainLine extends TransportationLine {

  TrainLine();

  TrainLine.fromMap(Map trainLineMap) : super.fromMap(trainLineMap);

  Map toJson() {
    Map json = super.toJson();
    json["@type"] = "TrainLine";
    return json;
  }
  
}
