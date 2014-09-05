part of model;

class CustomMap extends GMap {

  CustomMap(Node mapDiv): super(mapDiv) {
    zoom = 9;
    center = new LatLng(33.55770396470521, -7.5963592529296875);
    mapTypeId = MapTypeId.ROADMAP;
    visualRefresh = true;
  }
}
