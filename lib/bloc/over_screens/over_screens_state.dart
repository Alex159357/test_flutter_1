abstract class OverScreensState {
}

class LoadingScreen extends OverScreensState{}

class InitialScreen extends OverScreensState{}

class ErrorScreen extends OverScreensState{
  final message;

  ErrorScreen(this.message);
}
