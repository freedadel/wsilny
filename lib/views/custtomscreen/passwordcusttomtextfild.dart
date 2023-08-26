import 'package:flutter/material.dart';
import 'package:wsilny/utils/colors.dart';
import 'package:wsilny/utils/mediaqury.dart';
import 'package:provider/provider.dart';

import '/../utils/colornotifire.dart';

class PasswordCusttomTextfild extends StatefulWidget {
  final String? hintText;
  final TextEditingController textController;

  const PasswordCusttomTextfild(this.hintText,this.textController, {Key? key}) : super(key: key);

  @override
  State<PasswordCusttomTextfild> createState() =>
      _PasswordCusttomTextfildState();
}

class _PasswordCusttomTextfildState extends State<PasswordCusttomTextfild> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    late ColorNotifier notifier;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Container(
      color: Colors.transparent,
      height: height / 13,
      width: width / 1.1,
      child: TextField(
        controller: widget.textController,
        style: TextStyle(color: notifier.getblack),
        obscureText: _obscureText,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
              onTap: () {
                _toggle();
              },
              child: _obscureText
                  ? const Icon(Icons.remove_red_eye_rounded)
                  : const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.grey,
                    )),
          contentPadding: const EdgeInsets.only(left: 10),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: greay,
            fontFamily: 'Tajawal',
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

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
