part of controller;

@Injectable()
class BusStationController extends StationController {

  BusStationController(BusStationService service) : super(service);

  create(MouseEvent e) {
    (_service as BusStationService).create(e.latLng);
  }

}

@Injectable()
class BusStationService extends StationService {

  BusStationService(WSStation webService) : super(webService);

  create(LatLng latLng) {
    selected = new BusStation(latLng.lat, latLng.lng);
  }

}
