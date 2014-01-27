import 'dart:html';
import 'dart:collection';
import 'dart:convert';
import 'dart:async';
//import 'package:google_maps/google_maps.dart';
//import 'package:js/js.dart' as js;
import 'bus_line.dart';
import 'tramway_line.dart';
import 'train_line.dart';
import 'custom_map.dart';
import 'map_point.dart';
import 'transportation_line.dart';
import 'station.dart';

String webServiceUrl = "http://localhost:8080/Transportation-web/rest/";
//TransportationLine transportationLine;
CustomMap map;
InputElement lineName = querySelector('#lineName');
ButtonElement addLine = querySelector('#addLine');
ButtonElement saveLine = querySelector('#saveLine');
SelectElement lines = querySelector('#lines');
SelectElement transportationLineType = querySelector('#transportationLineType');
RadioButtonInputElement stationMode = querySelector('#stationMode');
RadioButtonInputElement lineMode = querySelector('#lineMode');
SelectElement stationType = querySelector('#stationType');
ButtonElement saveStations = querySelector('#saveStations');
void main() {
  map = new CustomMap(querySelector("#map"));
  stationMode.onClick.listen((e){
    setStationMode();
  });
  lineMode.onClick.listen((e){
    setLineMode();
  });
  map.selectedTransportationLine = new BusLine(map);
  refreshTransportationLines();
  refreshStations();
  lines.onChange.listen((e){
    OptionElement option = lines.selectedOptions.first;
    HttpRequest.getString(webServiceUrl+"TransportationLine/"+option.value).then((response){
      //print(response);
      Map transportationLineMap = JSON.decode(response);
      map.selectedTransportationLine.map = null;
      map.selectedTransportationLine = createTransportationLine(transportationLineMap);
      lineName.value = map.selectedTransportationLine.name;
    });
  });
  transportationLineType.onChange.listen((e){
    map.selectedTransportationLine.map = null;
    switch (transportationLineType.selectedOptions.first.value){
      case "BUS_LINE" :
        map.selectedTransportationLine = new BusLine(map);
        break;
      case "TRAIN_LINE" :
        map.selectedTransportationLine = new TrainLine(map);
        break;
      case "TRAMWAY_LINE" :
        map.selectedTransportationLine = new TramwayLine(map);
        break;
    }
  });
  addLine.onClick.listen((e){
    map.selectedTransportationLine.name = lineName.value;
    //print(map.selectedTransportationLine.toJson().toString());
    HttpRequest httpRequest = new HttpRequest()
      ..open("PUT", webServiceUrl+"TransportationLine/")
      ..setRequestHeader('content-type', 'application/json')
      ..send(map.selectedTransportationLine.toJson().toString())
      ;
  });
  saveLine.onClick.listen((e){
    map.selectedTransportationLine.name = lineName.value;
    HttpRequest httpRequest = new HttpRequest()
      ..open("POST", webServiceUrl+"TransportationLine/"+map.selectedTransportationLine.id)
      ..setRequestHeader('content-type', 'application/json')
      ..send(map.selectedTransportationLine.toJson().toString())
      ;
  });
  saveStations.onClick.listen((e){
    for(int i = 0; i<map.stations.length;i++){
      Station station = map.stations.elementAt(i);
      if(station.marker.visible == false){
      //if(station.marker.map == null){
        HttpRequest httpRequest = new HttpRequest()
          ..open("DELETE", "http://localhost:8080/Transportation-web/rest/Station/"+station.id)
          ..setRequestHeader('content-type', 'application/json')
          ..send()
          ;
        map.stations.removeAt(i);
      }
    }
    for(Station station in map.stations){
      HttpRequest httpRequest = new HttpRequest()
      ..open("POST", webServiceUrl+"Station")
      ..setRequestHeader('content-type', 'application/json')
      ..send(JSON.encode(station))
      ;
      //print(station.toJson());
    }
  });
}

StreamSubscription stream;

void setLineMode(){
  if(stream != null){
    stream.cancel();
  }
  stream = map.onClick.listen((e) {
    map.selectedTransportationLine.path.push(new MapPoint(e.latLng.lat, e.latLng.lng));
  });
}

void setStationMode(){
  if(stream != null){
    stream.cancel();
  }
  stream = map.onClick.listen((e){
    Station station;
    switch (stationType.selectedOptions.first.value){
      case "BUS_STATION" : 
        station = new BusStation(e.latLng.lat, e.latLng.lng, map);
        break;
      case "TRAIN_STATION" : 
        station = new TrainStation(e.latLng.lat, e.latLng.lng, map);
        break;
      case "TRAMWAY_STATION" : 
        station = new TramwayStation(e.latLng.lat, e.latLng.lng, map);
        break;
    }
    if(station != null){
      map.stations.add(station);
    }
  });
}

void refreshTransportationLines(){
  HttpRequest.getString(webServiceUrl+"TransportationLine/").then((response){
    //print(response);
    List<TransportationLine> transportationLines = JSON.decode(response);
    TransportationLine tempTransportationLine;
    for(LinkedHashMap transportationLineMap in transportationLines){
      tempTransportationLine = new BusLine.fromMap(transportationLineMap,map);
      lines.children.add(new OptionElement(data: tempTransportationLine.name, value: tempTransportationLine.id, selected: false));
    }
  });
}

void refreshStations(){
  HttpRequest.getString(webServiceUrl+"Station/").then((response){
    //print(response);
    List stations = JSON.decode(response);
    for(Map station in stations){
      //map.createStation(, , );
      switch (station["@type"]) {
        case "BusStation" :
            map.stations.add(new BusStation(station["latitude"], station["longitude"], map, station["id"]));
          break;
        case "TrainStation" :
            map.stations.add(new TrainStation(station["latitude"], station["longitude"], map, station["id"]));
          break;
        case "TramwayStation" :
            map.stations.add(new TramwayStation(station["latitude"], station["longitude"], map, station["id"]));
          break;
      }
    }
    //map.showStations();
  });
}

TransportationLine createTransportationLine(Map transportationLineMap){
  TransportationLine transportationLine;
  switch (transportationLineMap["@type"]){
    case "BusLine" :
      transportationLine = new BusLine.fromMap(transportationLineMap,map);   
      break;
    case "TrainLine" :
      transportationLine = new TrainLine.fromMap(transportationLineMap,map);   
      break;
    case "TramwayLine" :
      transportationLine = new TramwayLine.fromMap(transportationLineMap,map);   
      break;
  }
  return transportationLine;
}
