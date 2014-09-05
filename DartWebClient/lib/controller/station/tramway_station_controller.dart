part of controller;

@Controller(selector: '[tramway-station-ctrl]', publishAs: 'ctrl')
class TramwayStationController extends StationController {

  TramwayStationController(TramwayStationService service) : super(service);

  create(LatLng latLng) {
    (_service as TramwayStationService).create(latLng);
  }

}

@Injectable()
class TramwayStationService extends StationService {

  TramwayStationService(WSStation webService, CustomMapRepository customMapRepository) : super(webService, customMapRepository);

  create(LatLng latLng) {
    selected = new TramwayStation.fromLatLng(latLng);
  }

}
