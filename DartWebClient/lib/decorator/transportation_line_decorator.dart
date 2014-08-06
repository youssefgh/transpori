part of decorator;

@Decorator(selector: '[transportation-line]')
class TransportationLineDecorator implements AttachAware, DetachAware {

  final Element element;
  @NgTwoWay('transportationLine')
  TransportationLine originTransportationLine;
  TransportationLine transportationLine;
  @NgTwoWay('gmaps')
  CustomMap customMap;
  @NgCallback('on-click')
  Function onClick;
  @NgTwoWay('line-link-mode')
  bool lineLinkMode;
  @NgTwoWay('selected-map-point')
  MapPoint selectedMapPoint;

  TransportationLineDecorator(this.element);

  //TODO inspect callback is always not null
  attach() {//print("attt");
    transportationLine = originTransportationLine;
    transportationLine.show(customMap);
    transportationLine.onClick.listen((e) {
      if (onClick != null) {
        if (lineLinkMode == null || !lineLinkMode) onClick(); else {
          //int i = transportationLine.mapPoints.indexOf(new MapPoint.fromLatLng(e.latLng));
          //print(i);
          //print(e.latLng);
          selectedMapPoint = transportationLine.mapPoints.firstWhere((mapPoint)=>mapPoint.equals(e.latLng));/*
          transportationLine.mapPoints.forEach((m){
            print(m);
          });*/
          /*
          selectedMapPoint = transportationLine.mapPoints.elementAt(i);*/
          if (selectedMapPoint == null) {
            window.alert("No point selected");
          }
        }
      }
    });
  }

  detach() {//print("deeeet");
    transportationLine.hideWithStations();
  }

}
