part of controller;

@Controller(selector: '[transportation-line-ctrl]', publishAs: 'ctrl')
class TransportationLineController {
  
  TransportationLineService _service;

  bool lineLinkMode = false;
  MapPoint selectedMapPoint;

  TransportationLineController(this._service);

  get selected => _service.selected;
  set selected(TransportationLine selected) => _service.selected = selected;
  get stations => _service.stations;
  get transportationLines => _service.transportationLines;
  get selectedTransportationLines => _service.selectedTransportationLines;
  get customMap => _service.customMap;
  set customMap(CustomMap customMap) => _service.customMap = customMap;

  addMapPoint(LatLng latLng) {
    _service.addMapPoint(latLng);
  }

  //TODO review
  addStation(Station station) {
    if (!lineLinkMode) _service.addStation(station); else {
      if (selectedMapPoint != null) _service.setStation(station, selectedMapPoint); else window.alert("select a MapPoint first");
    }
  }

  select(TransportationLine transportationLine) {
    _service.select(transportationLine);
  }
  
  addToSelection(TransportationLine transportationLine) {
    _service.addToSelection(transportationLine);
  }

  save() {
    _verifyEmptyPath();
    _service.save();
  }

  saveReverseLine() {
    _verifyEmptyPath();
    _service.saveReverseLine();
  }

  _verifyEmptyPath() {
    if (_service.pathIsEmpty) {
      window.alert("Line not added : path is empty");
      return;
    }
  }

  update() {
    _service.update();
  }

  delete() {
    _service.delete();
  }

  showAll() {
    _service.showAll();
  }

  hideAll() {
    _service.hideAll();
  }

  undo() {
    _service.undo();
  }
  
}

@Injectable()
class TransportationLineService {

  TransportationLine _selected;
  List<TransportationLine> transportationLines = new List();
  List<Station> stations = new List();
  List<TransportationLine> selectedTransportationLines = new List();
  WSTransportationLine webService;
  CustomMap customMap;

  TransportationLineService(this.webService, CustomMapRepository customMapRepository, StationService stationService) {
    customMap = customMapRepository.transportationLineCustomMap;
    _refreshTransportationLines();
    stationService._refreshStations().then((e) {
      stations = stationService.stations;
      stations.forEach((station) {
        station.stationMarker.draggable = false;
      });
    });
  }

  TransportationLine get selected => _selected;

  set selected(TransportationLine transportationLine) {
    if (transportationLine != null) transportationLine.editable = true;
    _selected = transportationLine;
  }

  get pathIsEmpty => selected.path.length == 0;

  addMapPoint(LatLng latLng) {
    MapPoint mapPoint = new MapPoint.fromLatLng(latLng);
    selected.path.push(mapPoint);
  }

  addStation(Station station) {
    selected.path.push(station);
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
    webService.create(selected).then((id) {
      selected.id = id;
      transportationLines.add(selected);
    });
  }

  //TODO fix same reference issue 
  saveReverseLine() {
    selected.id = null;
    selected.reverseMapPoints();
    save();
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
  
}