part of controller;

@Injectable()
class TransportationRequestController {

  GMap gmap;

  TransportationRequestService _service;

  MapPoint navigationPosition;
  MapPoint originPosition;
  MapPoint destination;
  MapPoint mapPointPosition;

  Timer timer;
  int ip, jp;

  TransportationRequestController(this._service);

  get selectedTransportationPath => _service.selectedTransportationPath;
  set selectedTransportationPath(TransportationPath selectedTransportationPath) => _service.selectedTransportationPath = selectedTransportationPath;
  get transportationPaths => _service.transportationPaths;

  gmapCreated(GMap gmap) {
    this.gmap = gmap;
  }

  mapClick(MouseEvent e) {
    if (originPosition == null) {
      originPosition = new MapPoint(e.latLng.lat, e.latLng.lng);
    } else {
      if (destination == null) destination = new MapPoint(e.latLng.lat, e.latLng.lng);
    }
  }

  getPaths() {
    _service.clearTransportationPaths();
    if (timer != null && timer.isActive) {
      _clearNavigationPosition();
    }
    _service.getPaths(originPosition, destination);
  }

  //TODO use decorator's show() and hide() && review
  select(TransportationPath transportationPath) {
    if (_service.selectedTransportationPath != null) {
      _service.clearSelectedTransportationPath();
      navigationPosition = null;
    }
    _service.select(transportationPath);
    int length = _service.selectedTransportationPath.length();
    if (timer != null && timer.isActive) {
      _clearNavigationPosition();
    }
    int i = 0;
    ip = 0;
    jp = 0;
    timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) {
      next();
      if (i == length) {
        _clearNavigationPosition();
      }
      i++;
    });
  }

  _clearNavigationPosition() {
    navigationPosition = null;
    timer.cancel();
  }

  bool next() {
    if (navigationPosition == null) {
      navigationPosition = _service.selectedTransportationPath.transportationLines.first.mapPoints.first;
      mapPointPosition = _service.selectedTransportationPath.transportationLines.first.mapPoints.first;
    } else {
      bool found = false;
      for (int i = ip; i < _service.selectedTransportationPath.transportationLines.length; i++) {
        TransportationLine transportationLine = _service.selectedTransportationPath.transportationLines[i];
        for (int j = jp; j < transportationLine.mapPoints.length; j++) {
          MapPoint mapPoint = transportationLine.mapPoints[j];
          if (found && mapPoint is Station) {
            navigationPosition = mapPoint;
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
    for (TransportationLine transportationLine in _service.selectedTransportationPath.transportationLines.reversed) {
      for (MapPoint mapPoint in transportationLine.mapPoints.reversed) {
        if (found && mapPoint is Station) {
          navigationPosition = mapPoint;
          return;
        }
        if (mapPoint.equals(navigationPosition)) {
          found = true;
        }
      }
    }
  }

  LatLngWrapper infoWindowPosition;
  TransportationLine overTransportationLine; 
  
  mouseOver(PolyMouseEvent e,TransportationLine overTransportationLine) {
    //this.overTransportationLine = overTransportationLine;
    //infoWindowPosition = new LatLngWrapper.fromLatLng(e.latLng);
  }

  mouseOut(PolyMouseEvent e) {
    //overTransportationLine = null;
    //infoWindowPosition = null;
  }

  bool isReadyToSearchPaths() => isHaveDestination() && isHaveOriginPosition();

  bool isHaveOriginPosition() => originPosition != null;

  bool isHaveDestination() => destination != null;

}

@Injectable()
class TransportationRequestService {

  TransportationPath selectedTransportationPath;
  WSTransportationRequest webService;

  List<TransportationPath> transportationPaths = new List();

  TransportationRequestService(this.webService);

  getPaths(MapPoint originPosition, MapPoint destination) {
    TransportationRequest transportationRequest = new TransportationRequest(originPosition, destination);
    selectedTransportationPath = null;
    webService.update(transportationRequest).then((transportationPaths) {
      this.transportationPaths.clear();
      this.transportationPaths.addAll(transportationPaths);
    });
  }

  select(TransportationPath transportationPath) {
    selectedTransportationPath = transportationPath;
  }

  clearSelectedTransportationPath() {
    selectedTransportationPath = null;
  }

  clearTransportationPaths() {
    transportationPaths.clear();
  }

}
