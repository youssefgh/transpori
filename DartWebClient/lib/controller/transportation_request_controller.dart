part of controller;

@Controller(selector: '[transportation-request-ctrl]', publishAs: 'ctrl')
class TransportationRequestController {

  CustomMap customMap;
  TransportationPath selectedTransportationPath;
  WSTransportationRequest webService;
  Marker navigationPosition = new Marker()..animation = Animation.BOUNCE;
  OriginPosition originPosition;
  Destination destination;
  MapPoint mapPointPosition;

  Timer timer;
  int ip, jp;

  TransportationRequestController(this.webService, CustomMapRepository customMapRepository) {
    customMap = customMapRepository.pathCustomMap;
  }

  getPaths() {
    customMap.clearTransportationPaths();
    if (timer != null && timer.isActive) {
      clearNavigationPosition();
    }
    TransportationRequest transportationRequest = new TransportationRequest(originPosition, destination);
    webService.update(transportationRequest).then((transportationPaths) {
      customMap.transportationPaths.clear();
      customMap.transportationPaths.addAll(transportationPaths);
    });
  }
  
  //TODO use decorator's show() and hide()
  select(TransportationPath transportationPath) {
    if (selectedTransportationPath != null) {
      //selectedTransportationPath = null;
      selectedTransportationPath.hide();
      navigationPosition.position = null;
    } else navigationPosition.map = customMap;
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

  bool get isReadyToSearchPaths => isHaveDestination && isHaveOriginPosition;

  bool get isHaveOriginPosition => originPosition != null && originPosition.isVisible();

  bool get isHaveDestination => destination != null && destination.isVisible();

}
