part of controller;

@Controller(selector: '[train-line-ctrl]', publishAs: 'ctrl')
class TrainLineController extends TransportationLineController {

  TrainLineController(WSTransportationLine webService, CustomMapRepository customMapRepository, StationController stationController) : super(webService, customMapRepository, stationController);

  create() {
    selected = new TrainLine();
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
