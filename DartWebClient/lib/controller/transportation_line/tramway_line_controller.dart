part of controller;

@Controller(selector: '[tramway-line-ctrl]', publishAs: 'ctrl')
class TramwayLineController extends TransportationLineController {

  TramwayLineController(TramwayLineService service) : super(service);

    create() {
      (_service as TramwayLineService).create();
    }
    
    addMapPoint(LatLng latLng) {
      _service.addMapPoint(latLng);
    }
    
    addStation(Station station) {
      _service.addStation(station);
    }

  }

  @Injectable()
  class TramwayLineService extends TransportationLineService {
    
    TramwayLineService(WSTransportationLine webService, CustomMapRepository customMapRepository, StationService stationService) : super(webService, customMapRepository, stationService);

    create() {
      selected = new TramwayLine();
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
