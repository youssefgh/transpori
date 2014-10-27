part of controller;

@Injectable()
class BusLineController extends TransportationLineController {

  BusLineController(BusLineService service) : super(service);

}

@Injectable()
class BusLineService extends TransportationLineService {

  BusLineService(WSTransportationLine webService, StationService stationService) : super(webService, stationService);

  create() {
    selected = new BusLine();
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
