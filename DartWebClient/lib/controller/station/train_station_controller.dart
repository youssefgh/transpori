part of controller;

@Controller(selector: '[train-station-ctrl]', publishAs: 'ctrl')
class TrainStationController extends StationController {

  TrainStationController(WSStation webService, CustomMapRepository customMapRepository) : super(webService, customMapRepository);

  create(LatLng latLng) {
    selected = new TrainStation.fromLatLng(latLng);
  }
  
}