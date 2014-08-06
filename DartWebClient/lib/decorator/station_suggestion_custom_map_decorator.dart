part of decorator;

@Decorator(selector: '[station-suggestion-custom-map]')
class StationSuggestionCustomMapDecorator implements AttachAware {
  
  final Element element;
  @NgTwoWay('gmaps')
  CustomMap customMap;
  @NgTwoWay('gmaps-on-click')
  Function onClick;

  StationSuggestionCustomMapDecorator(this.element);
  
  attach() {/*
    try {
      customMap = new CustomMap(element);
          customMap.onClickStreamSubscription = customMap.onClick.listen((e) {
            Station busStationSuggestion = new BusStationSuggestion(e.latLng.lat, e.latLng.lng);
            stationSuggestionWS.create(busStationSuggestion).then((id) {
              busStationSuggestion.id = id;
              busStationSuggestion.stationMarker.map = customMap;
              customMap.stationSuggestions.add(busStationSuggestion);
              //TODO remove replicated code
              busStationSuggestion.stationMarker.onRightclick.listen((e) {
                stationSuggestionWS.delete(busStationSuggestion).then((e) {
                  customMap.deleteStation(busStationSuggestion);
                });
              });
              busStationSuggestion.stationMarker.onDragend.listen((e) => stationWS.update(busStationSuggestion));
            });
          });
    } catch (e) {
      print("Map loading error");
    }*/
  }

}
