part of decorator;

@Decorator(selector: '[gmaps]')
class GMapsDecorator implements AttachAware {
  final Element divElement;
  @NgTwoWay('gmaps')
  CustomMap customMap;

  GMapsDecorator(this.divElement);
  
  attach() {
    try {
      customMap = new CustomMap(divElement);
    } catch (e) {
      print("Map loading error");
    }
  }

}
