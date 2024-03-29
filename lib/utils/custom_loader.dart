import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wsilny/utils/colors.dart';
import 'package:wsilny/utils/dimensions.dart';

import 'colornotifire.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.height20*5,
        width: Dimensions.width20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20*5/2),
          color: ColorNotifier().getbuttoncolor
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
