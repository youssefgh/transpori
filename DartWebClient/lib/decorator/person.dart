part of decorator;

@Decorator(selector: '[person-marker]')
class PersonDecorator extends MarkerDecorator {

  PersonDecorator() {}
  
  attach(){
    super.attach();
    marker.animation = Animation.BOUNCE;
    icon = new Icon()..url="images/person.png";

  }

}