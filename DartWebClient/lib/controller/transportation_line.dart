part of controller;

@Injectable()
class TransportationLineController {

  GMap gmap;

  TransportationLineService _service;

  bool lineLinkMode = false;
  MapPoint selectedMapPoint;

  TransportationLineController(this._service);

  get selected => _service.selected;
  set selected(TransportationLine selected) => _service.selected = selected;
  get stations => _service.stations;
  get transportationLines => _service.transportationLines;
  get selectedTransportationLines => _service.selectedTransportationLines;

  setLineLinkMode() {
    lineLinkMode = true;
  }

  gmapCreated(GMap gmap) {
    this.gmap = gmap;
  }

  addMapPoint(MouseEvent e) {
    _service.addMapPoint(e.latLng);
  }

  addStation(Station station) {
    if (!lineLinkMode) _service.addStation(station); else {
      if (selectedMapPoint != null) _service.setStation(station, selectedMapPoint); else window.alert("select a MapPoint first");
    }
  }

  selectMapPoint(MapPoint mapPoint) {
    if (lineLinkMode) selectedMapPoint = mapPoint;
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
  WSTransportationLine _webService;
  StationService _stationService;

  TransportationLineService(this._webService, this._stationService);

  //TODO implement a find specific for each type
  Future refreshTransportationLines() {
    return _webService.readAll().then((transportationLines) {
      this.transportationLines = transportationLines;
    }).then((e) {
      _stationService.refreshStations().then((e) {
        stations = _stationService.stations;
      });
    });
  }

  TransportationLine get selected => _selected;

  set selected(TransportationLine transportationLine) {
    _selected = transportationLine;
  }

  get pathIsEmpty => selected.mapPoints.length == 0;

  addMapPoint(LatLng latLng) {
    MapPoint mapPoint = new MapPoint(latLng.lat, latLng.lng);
    selected.mapPoints.add(mapPoint);
  }

  addStation(Station station) {
    selected.mapPoints.add(station);
  }

  setStation(Station station, MapPoint mapPoint) {
    selected.mapPoints[selected.mapPoints.indexOf(mapPoint)] = station;
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
    _webService.create(selected).then((id) {
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
    _webService.update(selected);
  }

  delete() {
    _webService.delete(selected).then((e) {
      transportationLines.remove(selected);
      selectedTransportationLines.remove(selected);
      selected = null;
    });
  }

  //TODO review name
  showAll() {
    selectedTransportationLines.addAll(transportationLines);
  }

  //TODO review name
  hideAll() {
    selectedTransportationLines.clear();
  }

  undo() {
    selectedTransportationLines.remove(selected);
    selected = null;
  }

}
