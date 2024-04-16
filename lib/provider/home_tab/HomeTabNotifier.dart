import 'package:flutter/foundation.dart';

class HomeTabNotifier extends ChangeNotifier {
  int _tabIndex = 0;

  getTabIndex() => _tabIndex;

  setTabIndex(int tabIndex) => _tabIndex = tabIndex;

  Future<void> changeTabIndex(int tabIndex) async {
    _tabIndex = tabIndex;
    notifyListeners();
  }

}