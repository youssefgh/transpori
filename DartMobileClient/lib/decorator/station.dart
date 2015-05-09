part of decorator;

abstract class StationDecorator extends MarkerDecorator {
}

@Decorator(selector: '[bus-station]')
class BusStationDecorator extends StationDecorator {

  BusStationDecorator() {

  }

}

@Decorator(selector: '[train-station]')
class TrainStationDecorator extends StationDecorator {

  TrainStationDecorator() {}

}

@Decorator(selector: '[tramway-station]')
class TramwayStationDecorator extends StationDecorator {

  TramwayStationDecorator() {

  }

}
