part of decorator;

abstract class TransportationLineDecorator extends PolylineDecorator {

}

@Decorator(selector: '[bus-line]')
class BusLineDecorator extends TransportationLineDecorator {
  BusLineDecorator() {}
  attach() {
    super.attach();
    strokeColor = "#3ADF00";
    polyline.options = new PolylineOptions()..strokeWeight = 2;
  }
}

@Decorator(selector: '[train-line]')
class TrainLineDecorator extends TransportationLineDecorator {
  TrainLineDecorator() {}
  attach() {
    super.attach();
    strokeColor = "#FF4000";
    polyline.options = new PolylineOptions()..strokeWeight = 4;
  }
}

@Decorator(selector: '[tramway-line]')
class TramwayLineDecorator extends TransportationLineDecorator {
  TramwayLineDecorator() {}
  attach() {
    super.attach();
    strokeColor = "#2E64FE";
    polyline.options = new PolylineOptions()..strokeWeight = 3;
  }
}
