part of controller;

@Controller(selector: '[station-ctrl]', publishAs: 'ctrl')
class StationController {

  Station selected;
  List<Station> selectedStations = new List();
  List<Station> stations = new List();
  WSStation webService;
  CustomMap customMap;

  StationController(this.webService, CustomMapRepository customMapRepository) {
    customMap = customMapRepository.stationCustomMap;
    _refreshStations();
  }

  Future _refreshStations() {
    return webService.readAll().then((List<Station> stations) {
      this.stations = stations;
    });
  }

  select(Station station) {
    selected = station;
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
