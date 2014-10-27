part of controller;

@Injectable()
class TramwayLineController extends TransportationLineController {

  TramwayLineController(TramwayLineService service) : super(service);

}

@Injectable()
class TramwayLineService extends TransportationLineService {

  TramwayLineService(WSTransportationLine webService, StationService stationService) : super(webService, stationService);

  create() {
    selected = new TramwayLine();
  }

  addMapPoint(LatLng latLng) {
    if (selected == null) create();
    super.addMapPoint(latLng);
  }

  addStation(Station station) {
    if (selected == null) create();
    super.addStation(station);
  }

}
