part of controller;

@Controller(selector: '[home-ctrl]', publishAs: 'ctrl')
class HomeController {

  //models
  CustomMap customMap;
  User user;
  TransportationLine selectedTransportationLine;
  OriginPosition originPosition;
  Destination destination;
  //WSs
  WSTransportationLine transportationLineWS = new WSTransportationLine();
  WSStation stationWS = new WSStation();
  WSStationSuggestion stationSuggestionWS = new WSStationSuggestion();
  WSTransportationRequest transportationRequestWS = new WSTransportationRequest();
  WSUser userWS = new WSUser();
  //UIs
  bool adminPanelShown = false;
  String mapMode;
  List transportationLineTypes = TransportationLine.types;
  List stationTypes = Station.types;
  String selectedTransportationLineType;
  String selectedStationType;
  Marker navigationPosition;

  HomeController() {
    navigationPosition = new Marker()..animation = Animation.BOUNCE;
    //TODO separate ctrl consernes
    new Future.delayed(new Duration(seconds: 1), () {
      navigationPosition.map = customMap;
      setPathMode();
    });
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
    customMap.cancelOnClick();
    customMap.onClickStreamSubscription = customMap.onClick.listen((e) {
      Station busStationSuggestion = new BusStationSuggestion(e.latLng.lat, e.latLng.lng);
      stationSuggestionWS.create(busStationSuggestion).then((id) {
        busStationSuggestion.id = id;
        busStationSuggestion.stationMarker.map = customMap;
        customMap.stationSuggestions.add(busStationSuggestion);
        //TODO remove replicated code
        busStationSuggestion.stationMarker.onRightclick.listen((e) {
          stationSuggestionWS.delete(busStationSuggestion).then((e) {
            customMap.deleteStation(busStationSuggestion);
          });
        });
        busStationSuggestion.stationMarker.onDragend.listen((e) => stationWS.update(busStationSuggestion));
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
      originPosition.show(customMap);
    }
    if (destination != null) {
      destination.show(customMap);
    }
    customMap.cancelOnClick();
    customMap.onClickStreamSubscription = customMap.onClick.listen((e) {
      if (originPosition == null || !originPosition.isVisible()) {
        originPosition = new OriginPosition(e.latLng, customMap);
      } else {
        if (destination == null || !destination.isVisible()) {
          destination = new Destination(e.latLng, customMap);
        }
      }
    });
  }

  bool lineLinkMode = false;
  MapPoint selectedMapPoint;

  void setLineMode() {
    mapMode = "LINE_MODE";
    refreshTransportationLines().then((e) {
      customMap.showtransportationLines();
    });
    refreshStations().then((e) {
      customMap.showStations();
    });
    customMap.cancelOnClick();
    customMap.onClickStreamSubscription = customMap.onClick.listen((e) {
      if (selectedTransportationLine != null) {
        if (!lineLinkMode) selectedTransportationLine.path.push(new MapPoint(e.latLng.lat, e.latLng.lng));
      }
    });
  }

  void setStationMode() {
    mapMode = "STATION_MODE";
    customMap.cancelOnClick();
    customMap.hidetransportationLines();
    refreshStations().then((e) {
      customMap.showStations();
    });
    customMap.cancelOnClick();
    customMap.onClickStreamSubscription = customMap.onClick.listen((e) {
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
        station.stationMarker.map = customMap;
        customMap.stations.add(station);
        //TODO remove replicated code
        //TODO review
        station.stationMarker.onClick.listen((e) {
          if (isPathMode()) {
            selectedTransportationLine.path.push(station);
          }
        });
        station.stationMarker.onRightclick.listen((e) {
          stationWS.delete(station).then((e) {
            customMap.deleteStation(station);
          });
        });
        station.stationMarker.onDragend.listen((e) => stationWS.update(station));
      });
    });
  }

  Future refreshTransportationLines() {
    return transportationLineWS.readAll().then((transportationLines) {
      customMap.transportationLines = transportationLines;
      /*
      for (TransportationLine transportationLine in transportationLines) {
        transportationLine.onClick.listen((e) {
          if (isLineMode()) {
            MapPoint newMapPoint = transportationLine.getClosestMapPoint(new MapPoint(e.latLng.lat, e.latLng.lng));
            if (newMapPoint != null) selectedTransportationLine.path.push(newMapPoint);
          }
        });
      }*//*
      map.transportationLines[1].path.push(new MapPoint(33.576595306396484+0.0005, -7.672984600067139+0.0005));*/
    });
  }

  Future refreshStations() {
    return stationWS.readAll().then((stations) {
      customMap.hideStations();
      customMap.stations = stations;
      for (Station station in customMap.stations) {
        //TODO remove replicated code
        station.stationMarker.onClick.listen((e) {
          if (isLineMode()) {
            if (lineLinkMode && selectedMapPoint != null) {
              selectedTransportationLine.path.setAt(selectedTransportationLine.mapPoints.indexOf(selectedMapPoint), station);
              lineLinkMode = false;
            } else {
              selectedTransportationLine.path.push(station);
            }
          }
        });
        station.stationMarker.onRightclick.listen((e) {
          stationWS.delete(station).then((e) {
            customMap.deleteStation(station);
          });
        });
        station.stationMarker.onDragend.listen((e) => stationWS.update(station));
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
    selectedTransportationLine.map = customMap;
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
          int i = selectedTransportationLine.mapPoints.indexOf(new MapPoint.fromLatLng(e.latLng));
          selectedMapPoint = selectedTransportationLine.mapPoints.elementAt(i);
          if (selectedMapPoint != null) {
            //selectedMapPoint = selectedTransportationLine.path.getAt(index);
          } else {
            window.alert("No point selected");
          }
        }
      });
    });
  }

  void getPaths() {
    /*
    MapPoint mapPoint = new MapPoint(0, 0);
    //map.panToBounds(new LatLngBounds(originPosition, destination));
    if (originPosition.lat > destination.lat) {
      mapPoint.lat = originPosition.lat-(originPosition.lat - destination.lat);
    } else {
      mapPoint.lat = destination.lat - (destination.lat - originPosition.lat);
    }
    mapPoint.lat = originPosition.lat;
    mapPoint.lng = originPosition.lng ;
    //
    if (originPosition.lng > destination.lng) {
      mapPoint.lng = originPosition.lng - destination.lng;
    } else {
      mapPoint.lng = destination.lng - originPosition.lng;
    }
    map.center = originPosition;*/
    customMap.clearTransportationPaths();
    if (timer != null && timer.isActive) {
      clearNavigationPosition();
    }
    TransportationRequest transportationRequest = new TransportationRequest(originPosition, destination);
    transportationRequestWS.update(transportationRequest).then((transportationPaths) {
      //TODO verify clear effect
      customMap.transportationPaths.clear();
      customMap.transportationPaths.addAll(transportationPaths);
      //map.showTransportationPaths();
    });
  }

  Timer timer;
  int ip, jp;
  TransportationPath selectedTransportationPath;
  void select(TransportationPath transportationPath) {
    if (selectedTransportationPath != null) {
      selectedTransportationPath.hide();
      navigationPosition.position = null;
    }
    selectedTransportationPath = transportationPath;
    selectedTransportationPath.show(customMap);
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
    navigationPosition.map = customMap;
    timer.cancel();
  }

  MapPoint mapPointPosition;

  bool next() {
    if (navigationPosition.position == null) {
      navigationPosition.position = selectedTransportationPath.transportationLines.first.mapPoints.first;
      mapPointPosition = selectedTransportationPath.transportationLines.first.mapPoints.first;
    } else {
      bool found = false;
      for (int i = ip; i < selectedTransportationPath.transportationLines.length; i++) {
        TransportationLine transportationLine = selectedTransportationPath.transportationLines[i];
        for (int j = jp; j < transportationLine.mapPoints.length; j++) {
          MapPoint mapPoint = transportationLine.mapPoints[j];
          if (found && mapPoint is Station) {
            navigationPosition.position = mapPoint;
            mapPointPosition = mapPoint;
            ip = i;
            jp = j;
            return true;
          }
          if (mapPoint.equals(mapPointPosition)) {
            found = true;
          }
          jp = 0;
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
      transportationLineWS = new WSTransportationLine.withUser(user);
      stationWS = new WSStation.withUser(user);
      stationSuggestionWS = new WSStationSuggestion.withUser(user);
    }).catchError((e) {
      user.password = "";
    });
  }

  void logOut() {
    transportationLineWS = new WSTransportationLine();
    stationWS = new WSStation();
    stationSuggestionWS = new WSStationSuggestion();
    user = new User();
  }
}
