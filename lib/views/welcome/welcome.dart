import 'package:flutter/material.dart';
import 'package:wsilny/utils/colornotifire.dart';
import 'package:wsilny/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wsilny/utils/mediaqury.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late ColorNotifier notifier;
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
    // TODO: implement initState
    super.initState();
    getdarkmodepreviousstate();
  }
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor: notifier.getwihite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 8),
            Center(
              child: Image.asset("assets/loginsignselectlogo.png", height: height / 3),
            ),
            SizedBox(height: height / 15),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/SignIn');

              },
              child: button(
                tr("continueswithgoogle"),
                width / 1.1,
                notifier.getbuttoncolor,
                const Color(0xfffbf0e8),
                notifier.getbuttoncolor,
                "assets/googlelogo.png",
                buttoncolor,
              ),
            ),

            SizedBox(height: height / 45),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/SignIn');

              },
              child: button(
                tr("registerwithemail"),
                width / 1.1,
                notifier.getbuttoncolor,
                Colors.transparent,
                notifier.getbuttoncolor,
                "assets/email.png",
                notifier.getbuttoncolor,
              ),
            ),
            SizedBox(height: height / 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tr("alredyhaveanacount"),
                  style: TextStyle(
                    color: notifier.getblack,
                    fontSize: height / 55,
                    fontFamily: 'Tajawal',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/SignIn');
                  },
                  child: Text(
                    tr("signin"),
                    style: TextStyle(
                      color:  notifier.getbuttoncolor,
                      fontSize: height / 55,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget button(text, w, bordercolor, bcolor, textcolor, image, imagecolor) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: bordercolor, width: 1.5),
          color: bcolor,
          borderRadius: const BorderRadius.all(
            Radius.circular(22),
          ),
        ),
        height: height / 17,
        width: w,
        child: Row(
          children: [
            SizedBox(width: width / 15),
            Image.asset(image, height: height / 30, color: imagecolor),
            SizedBox(width: width / 25),
            Text(
              text,
              style: TextStyle(
                color: textcolor,
                fontSize: height / 45,
                fontFamily: 'Tajawal',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
