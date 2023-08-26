import 'package:flutter/cupertino.dart';
import 'package:wsilny/utils/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final String text;
  final Color iconColor;
  final IconData icon;
  const IconAndTextWidget({Key? key,
    required this.text,
    required this.iconColor,
    required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,) ,
        SizedBox(width: 5,),
        SmallText(text: text),

      ],
    );
  }
}
