part of controller;

@Controller(selector: '[bus-station-ctrl]', publishAs: 'ctrl')
class BusStationController extends StationController {

  BusStationController(BusStationService service) : super(service);

  create(LatLng latLng) {
    (_service as BusStationService).create(latLng);
  }

}

@Injectable()
class BusStationService extends StationService {

  BusStationService(WSStation webService, CustomMapRepository customMapRepository) : super(webService, customMapRepository);

  create(LatLng latLng) {
    selected = new BusStation.fromLatLng(latLng);
  }

}
