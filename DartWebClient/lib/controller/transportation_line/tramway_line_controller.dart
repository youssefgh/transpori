part of controller;

@Controller(selector: '[tramway-line-ctrl]', publishAs: 'ctrl')
class TramwayLineController extends TransportationLineController {

  TramwayLineController(WSTransportationLine webService, CustomMapRepository customMapRepository, StationController stationController) : super(webService, customMapRepository, stationController);

  create() {
    selected = new TramwayLine();
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
