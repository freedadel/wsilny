import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wassilni/utils/mediaqury.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previusstate;
    }
  }

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
    Timer(
      const Duration(seconds : 4),
          () => Navigator.pushReplacementNamed(context,  "/Onbonding")
    );
  }
late ColorNotifier notifier;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: notifier.getwihite,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: height / 3),
            Image.asset("assets/plashlogo.png",height: height/4),
            SizedBox(height: height / 40),
            Text(
              tr("yourpetispartofourfamily"),
              style: TextStyle(
                color: notifier.getblack,
                fontSize: height / 50,
                fontFamily: 'Tajawal',
              ),
            )
          ],
        ),
      ),
    );
  }
}
