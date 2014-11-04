part of decorator;

@Decorator(selector: '[custom-gmap]')
class CustomGMapDecorator extends GMapDecorator {

  CustomGMapDecorator(Element element) : super(element) {
    zoom = 9;
    center = new LatLng(33.55770396470521, -7.5963592529296875);
    mapTypeId = MapTypeId.ROADMAP;
  }

}
