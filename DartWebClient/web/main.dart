import 'package:angular/angular.dart' hide Animation;
import 'package:angular/application_factory.dart';
import 'dart:html' hide Animation;
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
  StationSuggestionWS stationSuggestionWS = new StationSuggestionWS();
  TransportationRequestWS transportationRequestWS = new TransportationRequestWS();
  UserWS userWS = new UserWS();
  //UIs
  bool adminPanelShown = false;
  String mapMode;
  List transportationLineTypes = TransportationLine.types;
  List stationTypes = Station.types;
  String selectedTransportationLineType;
  String selectedStationType;
  Marker navigationPosition;

  HomeController() {
    //print("test");
    navigationPosition = new Marker()..animation = Animation.BOUNCE;
    try {
      map = new CustomMap(querySelector("#map"));
      navigationPosition.map = map;
      setPathMode();
    } catch (e) {
      print("Map loading error");
    }
    //for test purposes
    user = new User();
    //user.id = "5399e80a2318e2764276aff6";
    //user.email = "admin@transpori.info";
    //user.password = "123456";
    //user.birthday = new DateTime.utc(1990);
    //user.firstName = "nnnnn";
    //manual login
    //user = new Administrator("youssef", "123456");
    //user = new User("youssef", "123456");
    /*
    logIn().then((e){
      refreshTransportationLines();
    });*/
    //originPosition = new OriginPosition(new LatLng(33.58716733904656, -7.6815032958984375), map);
    //destination = new Destination(new LatLng(33.571149664447326, -7.5311279296875), map);
    //originPosition = new OriginPosition(new LatLng(33.695208841799186, -7.38006591796875), map);
    //destination = new Destination(new LatLng(33.53967772193588, -7.6348114013671875), map);
    //getPaths();
  }

  bool isUserLoggedIn() {
    return user != null && user.id != null;
  }

  void moveAdminPanel() {
    //TODO improve with Angular style -> use decorator
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
      stationSuggestionWS.create(busStationSuggestion).then((id) {
        busStationSuggestion.id = id;
        busStationSuggestion.marker.map = map;
        map.stationSuggestions.add(busStationSuggestion);
        //TODO remove replicated code
        busStationSuggestion.marker.onRightclick.listen((e) {
          stationSuggestionWS.delete(busStationSuggestion).then((e) {
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

  bool lineLinkMode = false;
  MapPoint selectedMapPoint;

  void setLineMode() {
    mapMode = "LINE_MODE";
    refreshTransportationLines().then((e) {
      map.showtransportationLines();
    });
    refreshStations().then((e) {
      map.showStations();
    });
    map.cancelOnClick();
    map.onClickStreamSubscription = map.onClick.listen((e) {
      if (selectedTransportationLine != null) {
        if (!lineLinkMode) selectedTransportationLine.path.push(new MapPoint(e.latLng.lat, e.latLng.lng));
      }
    });
  }

  void setStationMode() {
    mapMode = "STATION_MODE";
    map.cancelOnClick();
    map.hidetransportationLines();
    refreshStations().then((e) {
      map.showStations();
    });
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
        //TODO review
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

  Future refreshTransportationLines() {
    return transportationLineWS.readAll().then((transportationLines) {
      map.transportationLines = transportationLines;
      /*
      for (TransportationLine transportationLine in transportationLines) {
        transportationLine.onClick.listen((e) {
          if (isLineMode()) {
            MapPoint newMapPoint = transportationLine.getClosestMapPoint(new MapPoint(e.latLng.lat, e.latLng.lng));
            if (newMapPoint != null) selectedTransportationLine.path.push(newMapPoint);
          }
        });
      }*//*
      print("added "+map.transportationLines.length.toString());
      map.transportationLines[1].path.push(new MapPoint(33.576595306396484+0.0005, -7.672984600067139+0.0005));
      print(map.transportationLines[1].path.length);
      print(map.transportationLines[0].path.length);*/
    });
  }

  Future refreshStations() {
    return stationWS.readAll().then((stations) {
      map.clearStations();
      map.stations = stations;
      for (Station station in map.stations) {
        //TODO remove replicated code
        station.marker.onClick.listen((e) {
          if (isLineMode()) {
            if (lineLinkMode && selectedMapPoint != null) {
              selectedTransportationLine.path.setAt(selectedTransportationLine.indexOf(selectedMapPoint), station);
              lineLinkMode = false;
            } else {
              selectedTransportationLine.path.push(station);
            }
          }
        });
        station.marker.onRightclick.listen((e) {
          stationWS.delete(station).then((e) {
            map.deleteStation(station);
          });
        });
        station.marker.onDragend.listen((e) => stationWS.update(station));
      }
    });
  }

  void newLine() {
    if (selectedTransportationLineType == null) {
      window.alert("No type selected");
      return;
    }
    if (selectedTransportationLine != null) {
      selectedTransportationLine.prepareForDelete();
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
    selectedTransportationLine.editable = true;
  }

  void addLine() {
    if (selectedTransportationLine.path.length != 0) transportationLineWS.create(selectedTransportationLine); else window.alert("Line not added : path is empty");
  }

  void addReverseLine() {
    selectedTransportationLine.id = null;
    selectedTransportationLine.reverseMapPoints();
    TransportationLine reverseLine = selectedTransportationLine;
    transportationLineWS.create(reverseLine);
  }

  //TODO implement line type change
  void saveLine() {
    transportationLineWS.update(selectedTransportationLine);
  }

  void deleteLine() {
    transportationLineWS.delete(selectedTransportationLine).then((e) {
      resetLine();
    });
  }

  void resetLine() {
    if (selectedTransportationLine != null) {
      selectedTransportationLine.prepareForDelete();
      selectedTransportationLine = null;
      selectedTransportationLineType = null;
      setLineMode();
    }
  }

  void transportationLineChanged() {
    if (selectedTransportationLine != null) selectedTransportationLine.editable = false;
    new Future(() {
      switch (selectedTransportationLine.runtimeType.toString()) {
        case "BusLine":
          selectedTransportationLineType = "BUS_LINE";
          break;
        case "TrainLine":
          selectedTransportationLineType = "TRAIN_LINE";
          break;
        case "TramwayLine":
          selectedTransportationLineType = "TRAMWAY_LINE";
          break;
      }
      selectedTransportationLine.editable = true;
      selectedTransportationLine.onClick.listen((e) {
        if (lineLinkMode) {
          //int index = selectedTransportationLine.path.getArray().indexOf(e.latLng);
          selectedMapPoint = selectedTransportationLine.getClosestMapPoint(new MapPoint(e.latLng.lat, e.latLng.lng));
          if (selectedMapPoint != null) {
            //selectedMapPoint = selectedTransportationLine.path.getAt(index);
          } else {
            window.alert("No point selected");
          }
        }
      });
    });
  }

  void getPaths() {/*
    MapPoint mapPoint = new MapPoint(0, 0);
    //map.panToBounds(new LatLngBounds(originPosition, destination));
    if (originPosition.lat > destination.lat) {
      mapPoint.lat = originPosition.lat-(originPosition.lat - destination.lat);
    } else {
      mapPoint.lat = destination.lat - (destination.lat - originPosition.lat);
    }print(originPosition.lat);
    mapPoint.lat = originPosition.lat;
    mapPoint.lng = originPosition.lng ;
    //
    if (originPosition.lng > destination.lng) {
      mapPoint.lng = originPosition.lng - destination.lng;
    } else {
      mapPoint.lng = destination.lng - originPosition.lng;
    }
    print(mapPoint.toJson());
    map.center = originPosition;*/
    map.clearTransportationPaths();
    if (timer != null && timer.isActive) {
      clearNavigationPosition();
    }
    TransportationRequest transportationRequest = new TransportationRequest(originPosition, destination);
    transportationRequestWS.update(transportationRequest).then((transportationPaths) {
      //TODO verify clear effect
      map.transportationPaths.clear();
      map.transportationPaths.addAll(transportationPaths);
      //map.showTransportationPaths();
    });
  }

  Timer timer;
  int ip ,jp;
  TransportationPath selectedTransportationPath;
  void select(TransportationPath transportationPath) {
    if (selectedTransportationPath != null) {
      selectedTransportationPath.hide();
      navigationPosition.position = null;
    }
    selectedTransportationPath = transportationPath;
    selectedTransportationPath.show(map);
    int length = selectedTransportationPath.length;
    if (timer != null && timer.isActive) {
      clearNavigationPosition();
    }
    int i = 0;
    ip = 0;
    jp = 0;
    timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) {
      next();
      if (i == length) {
        clearNavigationPosition();
      }
      i++;
    });
  }

  clearNavigationPosition() {
    navigationPosition.map = null;
    navigationPosition = new Marker()..animation = Animation.BOUNCE;
    navigationPosition.map = map;
    timer.cancel();
  }
  
  bool next() {
    if (navigationPosition.position == null) {
      navigationPosition.position = selectedTransportationPath.transportationLines.first.mapPoints.first;
    } else {
      bool found = false;
      for(int i = ip; i<selectedTransportationPath.transportationLines.length;i++){
        TransportationLine transportationLine = selectedTransportationPath.transportationLines[i];
        for(int j =jp;j<transportationLine.mapPoints.length;j++){
          MapPoint mapPoint = transportationLine.mapPoints[j];
          if (found && mapPoint is Station) {
            navigationPosition.position = mapPoint;
            ip = i;
            jp = j;
            return true;
          }
          if (mapPoint.equals(navigationPosition.position)) {
            found = true;
          }
          jp =0;
        }
      }
    }
    return false;
  }

  previous() {
    bool found = false;
    for (TransportationLine transportationLine in selectedTransportationPath.transportationLines.reversed) {
      for (MapPoint mapPoint in transportationLine.mapPoints.reversed) {
        if (found && mapPoint is Station) {
          navigationPosition.position = mapPoint;
          return;
        }
        if (mapPoint.equals(navigationPosition.position)) {
          found = true;
        }
      }
    }
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

  void signUp() {
    userWS.create(user).then((e) {
      user = new User();
      //FIXME find alternative solution
      context.callMethod(r'$', ['#signUpModal']).callMethod('modal', ['toggle']);
    }).catchError((e) {
      if ((e.target as HttpRequest).status == 406) {
        (querySelector('#email') as InputElement).placeholder = "Nouveau email";
        user.email = "";
      }
    });
  }

  Future logIn() {
    return userWS.read(user).then((user) {
      this.user = user;
      //FIXME find alternative solution
      context.callMethod(r'$', ['#logInModal']).callMethod('modal', ['toggle']);
      transportationLineWS = new TransportationLineWS.withUser(user);
      stationWS = new StationWS.withUser(user);
      stationSuggestionWS = new StationSuggestionWS.withUser(user);
    }).catchError((e) {
      user.password = "";
    });
  }

  void logOut() {
    transportationLineWS = new TransportationLineWS();
    stationWS = new StationWS();
    stationSuggestionWS = new StationSuggestionWS();
    user = new User();
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
  var s = new TransportationLine(null)
  ..id = "539f5cce231890d52b8abe99"
  ..toJson();
  
  HttpRequest.request("http://localhost:8081/rest/TransportationLine/", method: "DELETE", requestHeaders: {"content-type": "application/json", "authorization": "5399e80a2318e2764276aff6:123456"}, sendData: new TransportationLine(null)
          ..id = "539f5cce231890d52b8abe99"
          ..toJson().toString());
  print("okey");*/
  /*
  User user = new User();
  user.email = "admin@transpori.info";
  user.password = "123456";
  UserWS userWS = new UserWS();
  userWS.read(user).then((user) {
    print("logged");
  }).catchError((e) {
    user.password = "";
    print("error");
  });*/
  /*
  userWS.create(user).then((res){
    print("created");
  });
  */
  //.catchError((e){print("errr");});

  //TODO remove
  //for test purpose only
}
