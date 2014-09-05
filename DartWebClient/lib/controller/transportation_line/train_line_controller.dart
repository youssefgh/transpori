part of controller;

@Controller(selector: '[train-line-ctrl]', publishAs: 'ctrl')
class TrainLineController extends TransportationLineController {

  TrainLineController(TrainLineService service) : super(service);

  create() {
    (_service as TrainLineService).create();
  }

  addMapPoint(LatLng latLng) {
    _service.addMapPoint(latLng);
  }

  addStation(Station station) {
    _service.addStation(station);
  }

}

@Injectable()
class TrainLineService extends TransportationLineService {

  TrainLineService(WSTransportationLine webService, CustomMapRepository customMapRepository, StationService stationService) : super(webService, customMapRepository, stationService);

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
