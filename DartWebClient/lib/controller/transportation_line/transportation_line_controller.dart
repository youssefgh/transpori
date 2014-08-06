part of controller;

@Controller(selector: '[transportation-line-ctrl]', publishAs: 'ctrl')
class TransportationLineController {

  TransportationLine _selected;
  List<TransportationLine> transportationLines = new List();
  List<Station> stations = new List();
  List<TransportationLine> selectedTransportationLines = new List();
  WSTransportationLine webService;
  CustomMap customMap;

  bool _lineLinkMode = false;
  MapPoint selectedMapPoint;

  TransportationLineController(this.webService, CustomMapRepository customMapRepository, StationController stationController) {
    customMap = customMapRepository.transportationLineCustomMap;
    _refreshTransportationLines();
    //stations = stationController.stations;
    stationController._refreshStations().then((e) {
      stations = stationController.stations;
      stations.forEach((station) {
        station.stationMarker.draggable = false;
      });
    });
  }

  get lineLinkMode => _lineLinkMode;

  set lineLinkMode(bool value) {
    _lineLinkMode = value;
  }

  TransportationLine get selected => _selected;

  set selected(TransportationLine transportationLine) {
    if (transportationLine != null) transportationLine.editable = true;
    _selected = transportationLine;
  }

  addMapPoint(LatLng latLng) {
    MapPoint mapPoint = new MapPoint.fromLatLng(latLng);
    selected.path.push(mapPoint);
  }

  addStation(Station station) {
    if (!lineLinkMode) selected.path.push(station); else {
      if (selectedMapPoint != null) setStation(station, selectedMapPoint); else window.alert("select a MapPoint first");
    }
    //selected.mapPoints[selected.mapPoints.length-1] = station;
  }

  setStation(Station station, MapPoint mapPoint) {
    selected.path.setAt(selected.mapPoints.indexOf(mapPoint), station);
  }

  select(TransportationLine transportationLine) {
    selected = transportationLine;
  }
  
  //TODO selected is only rendered the first time
  addToSelection(TransportationLine transportationLine) {
    if (selectedTransportationLines.contains(transportationLine)) {
      selectedTransportationLines.remove(transportationLine);
      selected = null;
    } else {
      selectedTransportationLines.add(transportationLine);
      selected = transportationLine;
    }
  }

  save() {
    _verifyEmptyPath();
    webService.create(selected).then((id) {
      selected.id = id;
      transportationLines.add(selected);
      /*
      selectedTransportationLines.add(selected);
      selected = null;*/
    });
  }

  //TODO fix same reference issue 
  saveReverseLine() {
    _verifyEmptyPath();
    selected.id = null;
    selected.reverseMapPoints();
    save();
  }

  _verifyEmptyPath() {
    if (selected.path.length == 0) {
      window.alert("Line not added : path is empty");
      return;
    }
  }

  update() {
    webService.update(selected);
  }

  delete() {
    webService.delete(selected).then((e) {
      transportationLines.remove(selected);
      selected = null;
    });
  }

  Future _refreshTransportationLines() {
    return webService.readAll().then((transportationLines) {
      this.transportationLines = transportationLines;
    });
  }

  showAll() {
    selectedTransportationLines.addAll(transportationLines);
  }

  hideAll() {
    selectedTransportationLines.clear();
  }

  undo() {
    selectedTransportationLines.remove(selected);
    selected = null;
  }
  /*
  void resetLine() {
    if (selected != null) {
      selected.prepareForDelete();
      selected = null;
      selectedTransportationLineType = null;
    }
  }

  void transportationLineChanged() {
    if (selected != null) selected.editable = false;
    new Future(() {
      switch (selected.runtimeType.toString()) {
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
      selected.editable = true;
      selected.onClick.listen((e) {
        if (lineLinkMode) {
          int i = selected.mapPoints.indexOf(new MapPoint.fromLatLng(e.latLng));
          selectedMapPoint = selected.mapPoints.elementAt(i);
          if (selectedMapPoint != null) {
            //selectedMapPoint = selectedTransportationLine.path.getAt(index);
          } else {
            window.alert("No point selected");
          }
        }
      });
    });
  }*/

  /*
  void newLine() {
    if (selectedTransportationLineType == null) {
      window.alert("No type selected");
      return;
    }
    if (selected != null) {
      selected.prepareForDelete();
    }
    switch (selectedTransportationLineType) {
      case "BUS_LINE":
        selected = new BusLine();
        break;
      case "TRAIN_LINE":
        selected = new TrainLine();
        break;
      case "TRAMWAY_LINE":
        selected = new TramwayLine();
        break;
      default:
        window.alert("No line created");
        return;
    }
    selected.map = customMap;
    selected.editable = true;
  }
*/
}
