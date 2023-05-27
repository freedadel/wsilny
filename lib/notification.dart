import 'package:flutter/material.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/mediaqury.dart';

class Notif extends StatefulWidget {
  const Notif({Key? key}) : super(key: key);

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 14),
            Row(
              children: [
                SizedBox(width: width / 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,
                      size: height / 30, color: notifier.getbuttoncolor),
                ),
                const Spacer(),
                Text(
                  "Notification",
                  style: TextStyle(
                    color: notifier.getblack,
                    fontSize: height / 40,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(width: width / 2.3),
              ],
            ),
            notificationcard(
                "Doggo ipsum long woofer long bois dat tungg tho smol borking"),
            notificationcard(
                "What a nice floof fat boi blop boof bork, doing me a frighten"),
            notificationcard(
                " big ol tungg vvv adorable doggo.  Pupper woofer dat tungg tho corgo"),
          ],
        ),
      ),
    );
  }

  Widget notificationcard(txt) {
    return Stack(
      children: [
        Column(
          children: [SizedBox(height: height / 80), notificationcards(txt)],
        ),
        // Padding(
        //   padding: EdgeInsets.only(left: width / 10, top: height / 27),
        //   child:
        // )
      ],
    );
  }

  Widget notificationcards(txt) {
    return Center(
      child: Card(
        elevation: 1.5,
        color: notifier.getcardcolor,
        child: Container(
          color: Colors.transparent,
          height: height / 10,
          width: width / 1.1,
          child: Column(
            children: [
              SizedBox(height: height / 38),
              Row(
                children: [
                  SizedBox(width: width/30),
                  Image.asset("assets/notification.png", height: height / 22),
                  SizedBox(width: width/30),
                  Container(color: Colors.transparent,
                    width: width/1.5,
                    child: Text(
                      txt,
                      style: TextStyle(
                          fontSize: height / 60,
                          color: notifier.getblack,
                          fontFamily: 'Tajawal'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
