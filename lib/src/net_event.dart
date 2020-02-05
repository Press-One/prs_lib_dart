import 'package:event_bus/event_bus.dart';

class NetEvent {
  static final EventBus eventBus = new EventBus();
  static fireErrorEvent(code, message, noFire) {
    if (noFire) {
      return message;
    }
    eventBus.fire(new ErrorEvent(code, message));
    return message;
  }
}

class ErrorEvent {
  final int code;
  final String message;

  ErrorEvent(this.code, this.message);
}
