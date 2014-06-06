import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'dart:html';
import 'dart:js';
import 'dart:async';
import 'dart:collection';
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
import 'user.dart';
import 'package:google_maps/google_maps.dart';


@Controller(selector: '[home-ctrl]', publishAs: 'ctrl')
class HomeController {

  //models
  CustomMap map;
  User user;
  TransportationLine selectedTransportationLine;
  OriginPosition originPosition;
  Destination destination;
  //WSs
  TransportationLineWS transportationLineWS = new TransportationLineWS();
  StationWS stationWS = new StationWS();
  TransportationRequestWS transportationRequestWS = new TransportationRequestWS();
  UserWS userWS = new UserWS();
  //UIs
  bool adminPanelShown = false;
  String mapMode;
  List transportationLineTypes = TransportationLine.types;
  List stationTypes = Station.types;
  String selectedTransportationLineType;
  String selectedStationType;

  HomeController() {
    print("test");
    try {
      map = new CustomMap(querySelector("#map"));
      setPathMode();
    } catch (e) {
      print("Map loading error");
    }
    user = new User();
    //manual login
    //user = new Administrator("youssef", "123456");
    //user = new User("youssef", "123456");
    //for debugging purposes
    //TODO move
    //refreshTransportationLines();
    //refreshStations();
  }
  
  bool isUserLoggedIn(){
    return user != null && user.id != null;
  }

  void moveAdminPanel() {
    //TODO improve with Angular style
    adminPanelShown = !adminPanelShown;
    if (adminPanelShown) {
      querySelector('#administrator-panel').style.animation = "slide-up 1s";
      querySelector('#administrator-panel').style.animationFillMode = "forwards";
    } else {
      querySelector('#administrator-panel').style.animation = "slide-down 1s";
      querySelector('#administrator-panel').style.animationFillMode = "forwards";
      setPathMode();
    }
  }

  void setMapMode(String mapMode) {
    switch (mapMode) {
      case "PATH_MODE":
        setPathMode();
        break;
      case "STATION_MODE":
        setStationMode();
        break;
      case "LINE_MODE":
        setLineMode();
        break;
    }
    this.mapMode = mapMode;
  }

  void setSuggestionMode() {
    mapMode = "SUGGESTION";
    if (originPosition != null) {
      originPosition.hide();
    }
    if (destination != null) {
      destination.hide();
    }
    map.cancelOnClick();
        map.onClickStreamSubscription = map.onClick.listen((e) {
          Station busStationSuggestion = new BusStationSuggestion(e.latLng.lat, e.latLng.lng);
          stationWS.create(busStationSuggestion).then((id) {
            busStationSuggestion.id = id;
            busStationSuggestion.marker.map = map;
            map.stationSuggestions.add(busStationSuggestion);
            //TODO remove replicated code
            busStationSuggestion.marker.onRightclick.listen((e) {
              stationWS.delete(busStationSuggestion).then((e) {
                map.deleteStation(busStationSuggestion);
              });
            });
            busStationSuggestion.marker.onDragend.listen((e) => stationWS.update(busStationSuggestion));
          });
        });
    
  }

  bool isSuggestionMode() {
    return mapMode == "SUGGESTION";
  }

  bool isPathMode() {
    return mapMode == "PATH_MODE";
  }

  bool isStationMode() {
    return mapMode == "STATION_MODE";
  }

  bool isLineMode() {
    return mapMode == "LINE_MODE";
  }

  void setPathMode() {
    mapMode = "PATH_MODE";
    if (originPosition != null) {
      originPosition.show(map);
    }
    if (destination != null) {
      destination.show(map);
    }
    map.cancelOnClick();
    map.onClickStreamSubscription = map.onClick.listen((e) {
      if (originPosition == null || !originPosition.isVisible()) {
        originPosition = new OriginPosition(e.latLng, map);
      } else {
        if (destination == null || !destination.isVisible()) {
          destination = new Destination(e.latLng, map);
        }
      }
    });
  }

  void setLineMode() {
    mapMode = "LINE_MODE";
  }

  void setStationMode() {
    mapMode = "STATION_MODE";
    map.cancelOnClick();
    map.onClickStreamSubscription = map.onClick.listen((e) {
      Station station;
      switch (selectedStationType) {
        case "BUS_STATION":
          station = new BusStation(e.latLng.lat, e.latLng.lng);
          break;
        case "TRAIN_STATION":
          station = new TrainStation(e.latLng.lat, e.latLng.lng);
          break;
        case "TRAMWAY_STATION":
          station = new TramwayStation(e.latLng.lat, e.latLng.lng);
          break;
        default:
          window.alert("No station created");
          return;
      }
      stationWS.create(station).then((id) {
        station.id = id;
        station.marker.map = map;
        map.stations.add(station);
        //TODO remove replicated code
        station.marker.onClick.listen((e) {
          if (isPathMode()) {
            selectedTransportationLine.path.push(station);
          }
        });
        station.marker.onRightclick.listen((e) {
          stationWS.delete(station).then((e) {
            map.deleteStation(station);
          });
        });
        station.marker.onDragend.listen((e) => stationWS.update(station));
      });
    });
  }

  void refreshTransportationLines() {
    transportationLineWS.readAll().then((transportationLines) {
      map.transportationLines = transportationLines;
      for (TransportationLine transportationLine in transportationLines) {
        transportationLine.onClick.listen((e) {
          if (isLineMode()) {
            MapPoint newMapPoint = transportationLine.getClosestMapPoint(new MapPoint(e.latLng.lat, e.latLng.lng));
            if (newMapPoint != null) selectedTransportationLine.path.push(newMapPoint);
          }
        });
      }
      map.showtransportationLines();
    });
  }

  void refreshStations() {
    stationWS.readAll().then((stations) {
      map.clearStations();
      map.stations = stations;
      for (Station station in map.stations) {
        //TODO remove replicated code
        station.marker.onClick.listen((e) {
          if (isLineMode()) {
            selectedTransportationLine.path.push(station);
          }
        });
        station.marker.onRightclick.listen((e) {
          stationWS.delete(station).then((e) {
            map.deleteStation(station);
          });
        });
        station.marker.onDragend.listen((e) => stationWS.update(station));
      }
      map.showStations();
    });
  }

  void saveLine() {
    transportationLineWS.update(selectedTransportationLine);
  }

  void newLine() {
    if (selectedTransportationLineType == null) {
      window.alert("No type selected");
      return;
    }
    if (selectedTransportationLine != null) {
      selectedTransportationLine.prepareForDelete();
    } else {
      map.cancelOnClick();
    }
    switch (selectedTransportationLineType) {
      case "BUS_LINE":
        selectedTransportationLine = new BusLine();
        break;
      case "TRAIN_LINE":
        selectedTransportationLine = new TrainLine();
        break;
      case "TRAMWAY_LINE":
        selectedTransportationLine = new TramwayLine();
        break;
      default:
        window.alert("No line created");
        return;
    }
    selectedTransportationLine.map = map;
    map.onClickStreamSubscription = map.onClick.listen((e) {
      selectedTransportationLine.path.push(new MapPoint(e.latLng.lat, e.latLng.lng));
    });
  }

  void cancelLine() {
    if (selectedTransportationLine != null) {
      selectedTransportationLine.prepareForDelete();
      selectedTransportationLine = null;
      selectedTransportationLineType = null;
      setLineMode();
    }
  }

  void addLine() {
    if (selectedTransportationLine.path.length != 0) transportationLineWS.create(selectedTransportationLine); else window.alert("Line not added : path is empty");
  }

  void getPaths() {
    map.clearSuggestions();
    TransportationRequest transportationRequest = new TransportationRequest(originPosition, destination);
    transportationRequestWS.update(transportationRequest).then((transportationPaths) {
      //TODO verify clear effect
      map.suggestions.clear();
      map.suggestions.addAll(transportationPaths);
    });
  }

  bool isReadyToSearchPaths() {
    return isHaveDestination() && isHaveOriginPosition();
  }
  
  bool isHaveOriginPosition() {
      return originPosition != null && originPosition.isVisible();
  }
  
  bool isHaveDestination() {
    return destination != null && destination.isVisible();
  }
  
  void signUp(){
    userWS.create(user).then((e){
      print("subscribed");
      user = new User();
    });
  }
  
  void logIn(){
    userWS.read(user).then((user){
      this.user = user;
      print("logged");
      transportationLineWS = new TransportationLineWS.withUser(user);
      stationWS = new StationWS.withUser(user);
    }).catchError((e){
      user.password = "";
      print("error");
    });
  }
}

class MyAppModule extends Module {
  MyAppModule() {
    //type(GmapComponent);
    type(HomeController);
  }
}

void main() {
  applicationFactory().addModule(new MyAppModule()).run();
  /*
  User user = new User()
      //..birthday = new DateTime.now()
      //..email = "mail@m.com"
      //..firstName = "fname"
      ..name ="name"
      ..password="123"
      ..id = "id";
  UserWS userWS = new UserWS();
  userWS.create(user).then((res){
    print("created");
  });
  userWS.read(user).then((user){
    print(user.toJson());
  });*/
  
  //.catchError((e){print("errr");});
  
  //TODO remove
  //for test purpose only
}
