part of decorator;

@Decorator(selector: '[transportation-line-custom-map]')
class TransportationLineCustomMapDecorator implements AttachAware {
  
  final Element element;
  @NgTwoWay('gmaps')
  CustomMap customMap;
  @NgCallback('gmaps-on-click')
  Function onClick;

  TransportationLineCustomMapDecorator(this.element);
  
  attach() {
    try {
      customMap = new CustomMap(element);
      customMap.onClickStreamSubscription = customMap.onClick.listen((e) {
        if (onClick != null) {
          onClick({'\$latLng':e.latLng});
        }
      });
    } catch (e) {
      print("Map loading error");
    }
  }

}
