part of controller;

@Controller(selector: '[transportation-request-ctrl]', publishAs: 'ctrl')
class TransportationRequestController {

  TransportationRequestService _service;

  Marker navigationPosition = new Marker()..animation = Animation.BOUNCE;
  OriginPosition originPosition;
  Destination destination;
  MapPoint mapPointPosition;

  Timer timer;
  int ip, jp;

  TransportationRequestController(this._service);

  get selectedTransportationPath => _service.selectedTransportationPath;
  set selectedTransportationPath(TransportationPath selectedTransportationPath) => _service.selectedTransportationPath = selectedTransportationPath;
  get transportationPaths => _service.transportationPaths;
  get customMap => _service.customMap;
  set customMap(CustomMap customMap) => _service.customMap = customMap;

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
      _service.selectedTransportationPath.hide();
      navigationPosition.position = null;
    } else navigationPosition.map = _service.customMap;
    _service.select(transportationPath);
    int length = _service.selectedTransportationPath.length;
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
    navigationPosition.map = null;
    navigationPosition = new Marker()..animation = Animation.BOUNCE;
    navigationPosition.map = _service.customMap;
    timer.cancel();
  }

  bool next() {
    if (navigationPosition.position == null) {
      navigationPosition.position = _service.selectedTransportationPath.transportationLines.first.mapPoints.first;
      mapPointPosition = _service.selectedTransportationPath.transportationLines.first.mapPoints.first;
    } else {
      bool found = false;
      for (int i = ip; i < _service.selectedTransportationPath.transportationLines.length; i++) {
        TransportationLine transportationLine = _service.selectedTransportationPath.transportationLines[i];
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
    for (TransportationLine transportationLine in _service.selectedTransportationPath.transportationLines.reversed) {
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

  bool get isReadyToSearchPaths => isHaveDestination && isHaveOriginPosition;

  bool get isHaveOriginPosition => originPosition != null && originPosition.isVisible();

  bool get isHaveDestination => destination != null && destination.isVisible();

}

@Injectable()
class TransportationRequestService {

  CustomMap customMap;
  TransportationPath selectedTransportationPath;
  WSTransportationRequest webService;

  List<TransportationPath> transportationPaths = new List();

  TransportationRequestService(this.webService, CustomMapRepository customMapRepository) {
    customMap = customMapRepository.pathCustomMap;
  }

  showTransportationPaths() {
    for (TransportationPath transportationPath in transportationPaths) {
      transportationPath.show(customMap);
    }
  }

  HideTransportationPaths() {
    for (TransportationPath transportationPath in transportationPaths) {
      transportationPath.hide();
    }
  }

  void clearTransportationPaths() {
    HideTransportationPaths();
    for (TransportationPath transportationPath in transportationPaths) {
      for (TransportationLine transportationLine in transportationPath.transportationLines) {
        transportationLine.map = null;
      }
    }
  }

  getPaths(OriginPosition originPosition, Destination destination) {
    TransportationRequest transportationRequest = new TransportationRequest(originPosition, destination);
    webService.update(transportationRequest).then((transportationPaths) {
      this.transportationPaths.clear();
      this.transportationPaths.addAll(transportationPaths);
    });
  }

  //TODO review after gmaps decorator get introduced
  select(TransportationPath transportationPath) {
    selectedTransportationPath = transportationPath;
    selectedTransportationPath.show(customMap);
  }

}
