import 'package:flutter/material.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:wassilni/utils/mediaqury.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const CustomAppBar(this.title,{Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(180);

  @override
  Widget build(BuildContext context) {
    late ColorNotifier notifier;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Container(
      height: preferredSize.height,
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(height: height / 17),
          Row(
            children: [
              SizedBox(width: width / 25),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: notifier.getbuttoncolor,
                ),
              ),
            ],
          ),
          SizedBox(height: height / 45),
          Row(
            children: [
              SizedBox(width: width / 25),
              Text(
                title!,
                style: TextStyle(
                    color: notifier.getblack,
                    fontSize: height / 23,
                    fontFamily: 'Tajawal'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
