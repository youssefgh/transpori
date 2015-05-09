part of controller;

@Injectable()
class StationController {

  GMap gmap;

  StationService _service;

  StationController(this._service);

  get selected => _service.selected;
  set selected(selected) => _service.selected = selected;
  get stations => _service.stations;
  get selectedStations => _service.selectedStations;
  
  gmapCreated(GMap gmap) {
    this.gmap = gmap;
  }

  select(Station station) {
    _service.select(station);
  }

  addToSelection(Station station) {
    _service.addToSelection(station);
  }

  save() {
    _service.save();
  }

  update() {
    _service.update();
  }

  delete() {
    _service.delete();
  }

  showAll() {
    _service.showAll();
  }

  hideAll() {
    _service.hideAll();
  }

  undo() {
    _service.undo();
  }

}

@Injectable()
class StationService {

  Station selected;
  List<Station> selectedStations = new List();
  List<Station> stations = new List();
  WSStation webService;

  StationService(this.webService);
  
  //TODO implement a find specific for each type
  Future refreshStations() {
    return webService.readAll().then((List<Station> stations) {
      this.stations = stations;
    });
  }

  select(Station station) {
    selected = stations.elementAt(stations.indexOf(station));
    //TODO inspect clear effect on selected
    selectedStations.clear();
  }

  addToSelection(Station station) {
    if (selectedStations.contains(station)) selectedStations.remove(station); else selectedStations.add(station);
  }

  save() {
    webService.create(selected).then((id) {
      selected.id = id;
      stations.add(selected);
      selectedStations.add(selected);
      selected = null;
    });
  }

  update() {
    webService.update(selected);
  }

  delete() {
    webService.delete(selected).then((e) {
      stations.remove(selected);
      selected = null;
    });
  }

  showAll() {
    selectedStations.addAll(stations);
  }

  hideAll() {
    selectedStations.clear();
  }

  undo() {
    selectedStations.remove(selected);
    selected = null;
  }

}
