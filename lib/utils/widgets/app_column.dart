import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wsilny/utils/dimensions.dart';
import 'package:wsilny/utils/widgets/big_text.dart';
import 'package:wsilny/utils/widgets/icon_and_text_widget.dart';
import 'package:wsilny/utils/widgets/small_text.dart';
import '../colornotifire.dart';
import '../colors.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key,
  required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        //Comments sections
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => Icon(Icons.star,color: ColorNotifier().getbuttoncolor,size: 15,)),
            ),
          ],
        ),


      ],
    );
  }
}
