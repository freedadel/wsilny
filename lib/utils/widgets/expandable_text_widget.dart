import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wsilny/utils/colors.dart';
import 'package:wsilny/utils/dimensions.dart';
import 'package:wsilny/utils/widgets/small_text.dart';

import '../colornotifire.dart';

class Expandable extends StatefulWidget {
  final String text;

  const Expandable({Key? key,
    required this.text

  }) : super(key: key);

  @override
  State<Expandable> createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText=true;
  double textHeight=Dimensions.screenHeight/5.63;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalf=widget.text;
      secondHalf="";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(text: firstHalf,size: Dimensions.font16,color: AppColors.paraColor,height: 1.3,):Column(
        children: [
          SmallText(text: hiddenText?(firstHalf+"..."):(firstHalf+secondHalf),size: Dimensions.font16,color: AppColors.paraColor,height: 1.3,),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: hiddenText?tr("show_more"):tr("show_less"),color: ColorNotifier().getbuttoncolor,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: ColorNotifier().getbuttoncolor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
