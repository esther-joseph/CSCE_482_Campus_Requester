import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  //TODO should add Authentication service and make get current user

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
