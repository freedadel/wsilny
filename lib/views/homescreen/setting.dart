import 'package:flutter/material.dart';
import 'package:wassilni/loream.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:wassilni/utils/mediaqury.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:easy_localization/easy_localization.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value = false;

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
  }
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
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

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
                      size: height / 30, color:  notifier.getbuttoncolor),
                ),
                SizedBox(width: width / 3.1),
                Text(
                  tr("setting"),
                  style: TextStyle(color: notifier.getblack,
                    fontSize: height / 40,
                    fontFamily: 'Tajawal',
                  ),
                )
              ],
            ),
            SizedBox(height: height / 20),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/Notif');
                },
                child: settingoption("Notifications")),
            SizedBox(height: height / 20),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>   const Loream("Privacy Policy"),
                    ),
                  );
                },
                child: settingpolecy()),
            SizedBox(height: height / 20),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/FAQ');
                },
                child: settingoption("FAQ")),
          ],
        ),
      ),
    );
  }

  Widget settingoption(name) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(width: width / 13),
          Text(
            name,
            style:   TextStyle(
                fontFamily: 'Gilroy_Medium', fontSize: 17, color: notifier.getblack),
          ),
          const Spacer(),
            Icon(Icons.arrow_forward_ios, color: notifier.getgreay, size: 17),
          SizedBox(width: width / 20),
        ],
      ),
    );
  }

  Widget settingpolecy() {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(width: width / 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:   [
              Text(
                "Privacy Policy",
                style: TextStyle(
                    fontFamily: 'Gilroy_Medium',
                    fontSize: 17,
                    color: notifier.getblack),
              ),
              Text(
                "Choose what data you share with us",
                style: TextStyle(
                    fontFamily: 'Gilroy_Medium',
                    fontSize: 13,
                    color: notifier.getgreay),
              ),
            ],
          ),
          const Spacer(),
            Icon(Icons.arrow_forward_ios, color: notifier.getgreay, size: 17),
          SizedBox(width: width / 20),
        ],
      ),
    );
  }
}
