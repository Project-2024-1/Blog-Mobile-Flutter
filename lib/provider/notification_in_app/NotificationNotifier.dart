import 'package:flutter/foundation.dart';

class NotificationNotifier extends ChangeNotifier {
  bool _reloadWebviewIsNewNotification = false;

  getStatusReloadWebviewIsNewNotification() => _reloadWebviewIsNewNotification;

  void changeStatusReloadWebviewIsNewNotification(bool reloadWebviewIsNewNotification) {
    _reloadWebviewIsNewNotification = reloadWebviewIsNewNotification;
    notifyListeners();
  }
}
