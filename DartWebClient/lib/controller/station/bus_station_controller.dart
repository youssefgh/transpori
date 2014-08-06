part of controller;

@Controller(selector: '[bus-station-ctrl]', publishAs: 'ctrl')
class BusStationController extends StationController {

  BusStationController(WSStation webService, CustomMapRepository customMapRepository) : super(webService, customMapRepository);

  create(LatLng latLng) {
    selected = new BusStation.fromLatLng(latLng);
  }

}
