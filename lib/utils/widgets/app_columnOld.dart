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
            SizedBox(width:  Dimensions.width15,),
            SmallText(text: "4.5"),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "1256"),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "Comments")
          ],
        ),

        //Icons sections
        SizedBox(height: Dimensions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              text: "Normal",
              iconColor: Colors.deepOrangeAccent,
              icon: Icons.circle_sharp,
            ),
            IconAndTextWidget(
              text: "1.7km",
              iconColor: ColorNotifier().getbuttoncolor,
              icon: Icons.location_on,
            ),
            IconAndTextWidget(
              text: "32 minutes",
              iconColor: AppColors.iconColor2,
              icon: Icons.access_time_rounded,
            )
          ],
        )
      ],
    );
  }
}
