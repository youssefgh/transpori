part of controller;

@Injectable()
class TrainLineController extends TransportationLineController {

  TrainLineController(TrainLineService service) : super(service);

}

@Injectable()
class TrainLineService extends TransportationLineService {

  TrainLineService(WSTransportationLine webService, StationService stationService) : super(webService, stationService);

  create() {
    selected = new TrainLine();
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
