part of decorator;

abstract class Position extends MarkerDecorator {

  Position() {
    draggable = true;
  }

  attach() {
    super.attach();
    super.marker.onRightclick.listen((e) {
      super.position = null;
    });
  }

}

@Decorator(selector: '[start-marker]')
class StartDecorator extends Position {

}

@Decorator(selector: '[finish-marker]')
class FinishDecorator extends Position {

}
