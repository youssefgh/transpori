part of controller;

@Injectable()
class TramwayStationController extends StationController {

  TramwayStationController(TramwayStationService service) : super(service);

  create(MouseEvent e) {
    (_service as TramwayStationService).create(e.latLng);
  }

}

@Injectable()
class TramwayStationService extends StationService {

  TramwayStationService(WSStation webService) : super(webService);

  create(LatLng latLng) {
    selected = new TramwayStation(latLng.lat, latLng.lng);
  }

}
