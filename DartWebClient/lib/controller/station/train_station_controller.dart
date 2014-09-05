part of controller;

@Controller(selector: '[train-station-ctrl]', publishAs: 'ctrl')
class TrainStationController extends StationController {

  TrainStationController(TrainStationService service) : super(service);

  create(LatLng latLng) {
    (_service as TrainStationService).create(latLng);
  }

}

@Injectable()
class TrainStationService extends StationService {

  TrainStationService(WSStation webService, CustomMapRepository customMapRepository) : super(webService, customMapRepository);

  create(LatLng latLng) {
    selected = new TrainStation.fromLatLng(latLng);
  }

}
