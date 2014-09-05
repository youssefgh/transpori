part of decorator;

@Decorator(selector: '[path-custom-map]')
class PathCustomMapDecorator implements AttachAware {

  final Element element;
  @NgTwoWay('gmaps')
  CustomMap customMap;
  @NgTwoWay('originPosition')
  OriginPosition originPosition;
  @NgTwoWay('destination')
  Destination destination;

  PathCustomMapDecorator(this.element);

  attach() {
    try {
      customMap = new CustomMap(element);
      customMap.onClick.listen((e) {
        if (originPosition == null) {
          originPosition = new OriginPosition(e.latLng, customMap);
        } else {
          if (destination == null) {
            destination = new Destination(e.latLng, customMap);
          }
        }
      });
    } catch (e) {
      print("Map loading error");
    }
  }

}
