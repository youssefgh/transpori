part of decorator;

@Decorator(selector: '[person-marker]')
class PersonDecorator extends MarkerDecorator {

  PersonDecorator() {}
  
  set position(LatLngWrapper position) {
    super.position = position;
    _initAnimation();
  }
  attach(){
    super.attach();
    _initAnimation();
    icon = new Icon()..url="images/person.png";
  }
  
  _initAnimation(){
    marker.animation = Animation.BOUNCE;
  }

}