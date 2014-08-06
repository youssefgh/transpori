part of controller;

@Controller(selector: '[tramway-station-ctrl]', publishAs: 'ctrl')
class TramwayStationController extends StationController {

  TramwayStationController(WSStation webService, CustomMapRepository customMapRepository) : super(webService, customMapRepository);

  create(LatLng latLng) {
    selected = new TramwayStation.fromLatLng(latLng);
  }
  
}