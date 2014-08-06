part of decorator;

@Decorator(selector: '[station]')
class StationDecorator implements AttachAware, DetachAware {

  final Element element;
  @NgTwoWay('station')
  Station originStation;
  Station station;
  @NgTwoWay('gmaps')
  CustomMap customMap;
  @NgCallback('on-click')
  Function onClick;/*
  @NgCallback('set-station')
  Function setStation;*/
  @NgCallback('on-right-click')
  Function onRightclick;/*
  @NgCallback('on-drag-end')
  Function onDragend;*//*
  @NgTwoWay('lineLinkMode')
  bool lineLinkMode;*/

  StationDecorator(this.element);

  //TODO inspect callback is always not null
  attach() {
    station = originStation;
    station.stationMarker.map = customMap;
    station.stationMarker.onClick.listen((e) {
      if (onClick != null) onClick({"\$station":station});
    });
    station.stationMarker.onRightclick.listen((e) {
      if (onRightclick != null) onRightclick();
    });/*
    station.stationMarker.onDragend.listen((e) {
      if (onDragend != null) onDragend();
    });*/
  }

  detach() {
    station.stationMarker.map = null;
  }

}
