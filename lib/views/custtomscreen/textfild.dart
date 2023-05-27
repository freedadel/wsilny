import 'package:flutter/material.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:wassilni/utils/colors.dart';
import 'package:wassilni/utils/mediaqury.dart';
import 'package:provider/provider.dart';

class CusttomTextfild extends StatelessWidget {
  final String? hintText;
  TextEditingController? textEditingController;
  CusttomTextfild(this.hintText,this.textEditingController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late ColorNotifier notifier;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Container(
      color: Colors.transparent,
      height: height / 13,
      width: width / 1.1,
      child: TextField(
        controller: textEditingController,
        style: TextStyle(color: notifier.getblack),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10,right: 10),
          hintText: hintText,
          hintStyle: TextStyle(
            color: greay,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffE0E0E0),
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffE0E0E0),
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
