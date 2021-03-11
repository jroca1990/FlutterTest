import 'package:confeccionessaapp/models/user.dart';

class Application {
  static Application _singleton;
  User applicationUser;

  factory Application() {
    if (_singleton == null) {
      _singleton = Application._();
    }
    return _singleton;
  }

  Application._();
}
