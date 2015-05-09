part of decorator;

abstract class StationIconDecorator extends IconDecorator {
}

@Decorator(selector: '[bus-station-icon]')
class BusStationIconDecorator extends StationIconDecorator {

  BusStationIconDecorator() {}

  attach() {
    super.attach();
    url = "images/bus_station.png";
  }

}

@Decorator(selector: '[train-station-icon]')
class TrainStationIconDecorator extends StationIconDecorator {

  TrainStationIconDecorator() {}

  attach() {
    super.attach();
    url = "images/train_station.png";
  }

}

@Decorator(selector: '[tramway-station-icon]')
class TramwayStationIconDecorator extends StationIconDecorator {

  TramwayStationIconDecorator() {}

  attach() {
    super.attach();
    url = "images/tramway_station.png";
    scaledSize = new Size(12, 12);
  }

}
