part of decorator;

@Decorator(selector: '[transportation-path]')
class TransportationPathDecorator implements AttachAware, DetachAware {

  final Element element;
  @NgTwoWay('transportationPath')
  TransportationPath originTransportationPath;
  TransportationPath transportationPath;
  @NgTwoWay('gmaps')
  CustomMap customMap;/*
  @NgCallback('on-click')
  Function onClick;*/
  
  TransportationPathDecorator(this.element);

  //TODO inspect callback is always not null
  attach() {//print("att");
    transportationPath = originTransportationPath;
    transportationPath.show(customMap);
  }

  detach() {//print("det");
    transportationPath.hide();
  }

}
