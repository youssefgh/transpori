part of controller;

@Controller(selector: '[bus-line-ctrl]', publishAs: 'ctrl')
class BusLineController extends TransportationLineController {

  BusLineController(BusLineService service) : super(service);

  create() {
    (_service as BusLineService).create();
  }
  
  addMapPoint(LatLng latLng) {
    _service.addMapPoint(latLng);
  }
  
  addStation(Station station) {
    _service.addStation(station);
  }

}

@Injectable()
class BusLineService extends TransportationLineService {
  
  BusLineService(WSTransportationLine webService, CustomMapRepository customMapRepository, StationService stationService) : super(webService, customMapRepository, stationService);

  create() {
    selected = new BusLine();
  }
  
  addMapPoint(LatLng latLng) {
    if(selected == null) create();
    super.addMapPoint(latLng);
  }
  
  addStation(Station station) {
    if(selected == null) create();
    super.addStation(station);
  }

}
