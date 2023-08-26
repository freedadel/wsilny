import 'package:flutter/material.dart';
import 'package:wsilny/routes/route_helper.dart';
import 'package:wsilny/utils/dimensions.dart';
import 'package:wsilny/views/custtomscreen/button.dart';
import 'package:wsilny/utils/colornotifire.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wsilny/utils/mediaqury.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
class Succsess extends StatefulWidget {
  const Succsess({Key? key}) : super(key: key);

  @override
  State<Succsess> createState() => _SuccsessState();
}

class _SuccsessState extends State<Succsess> {
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
    return Scaffold(
      backgroundColor: notifier.getwihite,
      body: Padding(
        padding: EdgeInsets.all(Dimensions.width10),
        child: Column(
          children: [
            SizedBox(height: height / 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,
                      color:  notifier.getbuttoncolor, size: height / 30),
                ),
                // const Spacer(),
                // Icon(Icons.shopping_basket,
                //     color: buttoncolor, size: height / 30),
                SizedBox(width: width / 20),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.initial);
                  },
                  child: Icon(Icons.home_outlined,
                      color:  notifier.getbuttoncolor, size: height / 30),
                ),
              ],
            ),
            SizedBox(height: height / 8),
            Center(
              child: Image.asset("assets/successfuly.png", height: height / 3.5),
            ),
            SizedBox(height: height / 10),
            Text(
              tr("youshippingorderhas"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: height / 33,
                  fontFamily: 'Tajawal',
                  color: notifier.getblack),
            ),
            SizedBox(height: height / 13),
            Text(
              tr("thakyouforyouyrorder"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: notifier.getgreay,
                  fontSize: height / 50,
                  fontFamily: 'Tajawal'),
            ),
            SizedBox(height: height / 7),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.orders);
              },
              child: Custombutton.button(
                tr("gotomyorder"),
                width / 1.1,
                notifier.getbuttoncolor,
                Colors.transparent,
                notifier.getbuttoncolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
