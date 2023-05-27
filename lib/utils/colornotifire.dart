import 'package:flutter/cupertino.dart';

import 'colors.dart';

class ColorNotifier with ChangeNotifier {
  bool isDark = false;

  set setIsDark(v) {
    isDark = v;
    notifyListeners();
  }

  get getIsDark => isDark;

  get getwihite => isDark ? darkwhite : white;

  get getblack => isDark ?  black : darkblack;

  get getgreay => isDark ? greay : darkgreay;

  get getbuttoncolor => isDark ? buttoncolor : darkbuttoncolor;

  get getcardcolor => isDark ? cardcolor : darkcardcolor;

  get getnewpetcolor => isDark ? darknewpetcolor :  newpetcolor;
}
