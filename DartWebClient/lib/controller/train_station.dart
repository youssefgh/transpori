part of controller;

@Injectable()
class TrainStationController extends StationController {

  TrainStationController(TrainStationService service) : super(service);

  create(MouseEvent e) {
    (_service as TrainStationService).create(e.latLng);
  }

}

@Injectable()
class TrainStationService extends StationService {

  TrainStationService(WSStation webService) : super(webService);

  create(LatLng latLng) {
    selected = new TrainStation(latLng.lat, latLng.lng);
  }

}
