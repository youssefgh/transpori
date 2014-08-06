part of controller;

@Controller(selector: '[bus-line-ctrl]', publishAs: 'ctrl')
class BusLineController extends TransportationLineController {

  BusLineController(WSTransportationLine webService, CustomMapRepository customMapRepository, StationController stationController) : super(webService, customMapRepository, stationController);

  create() {
    selected = new BusLine();
  }
  
  addMapPoint(LatLng latLng) {
    if(selected == null) create();
    super.addMapPoint(latLng);
  }
  
  addStation(Station station) {
    if(selected == null) create();
    super.addStation(station);
  }

}
