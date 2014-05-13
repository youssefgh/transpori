import 'dart:html';
import 'dart:collection';
import 'dart:convert';
import 'dart:async';
//import 'package:google_maps/google_maps.dart';
import 'bus_line.dart';
import 'tramway_line.dart';
import 'train_line.dart';
import 'custom_map.dart';
import 'map_point.dart';
import 'transportation_line.dart';
import 'station.dart';
import 'transportation_request.dart';
import 'transportation_path.dart';
import 'origin_position.dart';
import 'destination.dart';
import 'webservice_client.dart';

//String webServiceUrl = "http://tmorocco-mdeveloper.rhcloud.com/rest/";
//String webServiceUrl = "http://localhost:8080/Transportation-web/rest/";
//String webServiceUrl = "http://localhost:8080/rest/";
//TransportationLine transportationLine;
CustomMap map;
InputElement lineName = querySelector('#lineName');
ButtonElement addLine = querySelector('#addLine');
ButtonElement saveLine = querySelector('#saveLine');
ButtonElement getPaths = querySelector('#getPaths');
SelectElement lines = querySelector('#lines');
SelectElement transportationLineType = querySelector('#transportationLineType');
RadioButtonInputElement stationMode = querySelector('#stationMode');
RadioButtonInputElement lineMode = querySelector('#lineMode');
RadioButtonInputElement pathMode = querySelector('#pathMode');
SelectElement stationType = querySelector('#stationType');
ButtonElement saveStations = querySelector('#saveStations');
//WS
TransportationLineWS transportationLineWS = new TransportationLineWS();
StationWS stationWS = new StationWS();
TransportationRequestWS transportationRequestWS = new TransportationRequestWS();

void main() {
  map = new CustomMap(querySelector("#map"));
  stationMode.onClick.listen((e){
    setStationMode();
  });
  lineMode.onClick.listen((e){
    setLineMode();
  });
  pathMode.onClick.listen((e){
    setPathMode();
  });
  map.selectedTransportationLine = new BusLine(map);
  refreshTransportationLines();
  refreshStations();
  lines.onChange.listen((e){
    OptionElement option = lines.selectedOptions.first;
    transportationLineWS.get(option.value, map).then((TransportationLine transportationLine){
      map.selectedTransportationLine.map = null;
      map.selectedTransportationLine = transportationLine;
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
    transportationLineWS.put(map.selectedTransportationLine);
  });
  saveLine.onClick.listen((e){
    map.selectedTransportationLine.name = lineName.value;
    transportationLineWS.post(map.selectedTransportationLine);
  });
  saveStations.onClick.listen((e){
    for(int i = 0; i<map.stations.length;i++){
      Station station = map.stations.elementAt(i);
      if(station.marker.visible == false){
        stationWS.delete(station);
        map.stations.removeAt(i);
      }
    }
    for(Station station in map.stations){
      stationWS.post(station);
    }
  });
  getPaths.onClick.listen((e){
    map.clearSuggestions();
    TransportationRequest transportationRequest = new TransportationRequest(map.originPosition, map.destination);
    transportationRequestWS.post(transportationRequest, map, (List<TransportationPath> transportationPaths){
      //TODO verify clear effect
      map.suggestions.clear();
      map.suggestions.addAll(transportationPaths);
    });
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

void setPathMode(){
  if(stream != null){
    stream.cancel();
  }
  stream = map.onClick.listen((e){
    if(map.originPosition == null || map.originPosition.marker.visible == false){
      map.originPosition = new OriginPosition(e.latLng,map);
    } else {
      if(map.destination == null || map.destination.marker.visible == false){
        map.destination = new Destination(e.latLng,map);
      }   
    }
  });
}

void refreshTransportationLines(){
  transportationLineWS.get("", map).then((transportationLines){
    for(TransportationLine transportationLine in transportationLines){
      lines.children.add(new OptionElement(data: transportationLine.name, value: transportationLine.id, selected: false));
    }
  });
}

void refreshStations(){
  stationWS.get(map).then((stations){
    //TODO verify clear effect
    map.stations.clear();
    map.stations.addAll(stations);
  });
}
/*
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
}*/
