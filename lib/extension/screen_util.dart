import 'package:flutter/widgets.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
double globalWidth = MediaQuery.of(navigatorKey.currentContext!).size.width;
double globalHeight = MediaQuery.of(navigatorKey.currentContext!).size.height;

extension IntScreenUtil on int {
  double get w {
    return globalWidth * (this / 100);
  }

  double get h {
    return globalHeight * (this / 100);
  }
}

extension DoubleScreenUtil on double {
  double get w {
    return globalWidth * (this / 100);
  }

  double get h {
    return globalHeight * (this / 100);
  }
}
