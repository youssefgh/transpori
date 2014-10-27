part of controller;

@Injectable()
class IconController {

  Icon startIcon;
  Icon finishIcon;
  Icon busStationIcon;
  Icon trainStationIcon;
  Icon tramwayStationIcon;

  startIconCreated(Icon startIcon) {
    this.startIcon = startIcon;
  }

  finishIconCreated(Icon finishIcon) {
    this.finishIcon = finishIcon;
  }

  busStationIconCreated(Icon busStationIcon) {
    this.busStationIcon = busStationIcon;
  }

  trainStationIconCreated(Icon trainStationIcon) {
    this.trainStationIcon = trainStationIcon;
  }

  tramwayStationIconCreated(Icon tramwayStationIcon) {
    this.tramwayStationIcon = tramwayStationIcon;
  }

}
