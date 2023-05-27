import 'package:flutter/material.dart';

import '/../utils/mediaqury.dart';

class Custombutton {
  static Widget button(text, w, bordercolor, bcolor,textcolor) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: bordercolor,width: 1.5),
          color: bcolor,
          borderRadius: const BorderRadius.all(
            Radius.circular(22),
          ),
        ),
        height: height / 17,
        width: w,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color:textcolor,
                fontSize: height / 45,
                fontFamily: 'Tajawal'),
          ),
        ),
      ),
    );
  }
}
