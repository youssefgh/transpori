part of decorator;

abstract class PositionIconDecorator extends IconDecorator {
}

@Decorator(selector: '[start-icon]')
class StartIconDecorator extends PositionIconDecorator {

  StartStationIconDecorator() {}

  attach() {
    super.attach();
    url = "images/start.png";
  }

}

@Decorator(selector: '[finish-icon]')
class FinishIconDecorator extends PositionIconDecorator {

  FinishIconDecorator() {}

  attach() {
    super.attach();
    url = "images/finish.png";
  }

}
