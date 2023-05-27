import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class MediumText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;

  MediumText({Key? key, this.color = const Color(0xFFc5bfbc),
    this.size=15,
    this.height=1.5,
    required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontFamily: 'Tajawal',
          fontSize: size,
          height: height
      ),
    );
  }
}
