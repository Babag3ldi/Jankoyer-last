
import 'package:flutter/cupertino.dart';

class NavBarProvider with ChangeNotifier {
  bool showBottomNav = false;
  ValueNotifier<bool> changeState = ValueNotifier<bool>(false);
  setState() {
    changeState.value = true;
  }

  showBottom() {
    showBottomNav = false;
    // print(showBottomNav);
    notifyListeners();
  }

  unShowBottom() {
    showBottomNav = true;
    // print(showBottomNav);
    notifyListeners();
  }
}
