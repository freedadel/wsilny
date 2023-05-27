import 'package:flutter/material.dart';
import 'package:wassilni/controllers/auth_controller.dart';
import 'package:wassilni/views/homescreen/home.dart';
import 'package:wassilni/views/orderscreen/orders.dart';
import 'package:wassilni/views/user/user.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:wassilni/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authscreen/signin.dart';
import 'package:easy_localization/easy_localization.dart';
import '../msgs/msgslist.dart';
import '/../utils/mediaqury.dart';
import 'package:get/get.dart';

class Bottomhome extends StatefulWidget {
  const Bottomhome({Key? key}) : super(key: key);

  @override
  _BottomhomeState createState() => _BottomhomeState();
}

class _BottomhomeState extends State<Bottomhome> {
  int _selectedIndex = 0;

  String? name;
  DateTime? currentBackPressTime;
  bool shouldPop = false;
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
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

    final _pageOption;
    if(Get.find<AuthController>().userLoggedIN())
      {
        _pageOption = [
          const Home(),
          const Orders(),
          const Messages(),
          const User()
        ];
      }else{
        _pageOption = [
        const Home(),
        const SignIn(),
          const SignIn(),
        const SignIn()
      ];
    }

    return Scaffold(backgroundColor: notifier.getwihite,
      restorationId: "123",
      bottomNavigationBar: SalomonBottomBar(
        selectedColorOpacity: 1,
        curve: Curves.decelerate,
        itemShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        selectedItemColor: buttoncolor,
        currentIndex: _selectedIndex,
        items: [
          SalomonBottomBarItem(
            icon: Image.asset("assets/home.png",
                height: height / 40,
                color: _selectedIndex == 0 ? white : Colors.grey),
            title: Text(
              tr("home"),
              style: TextStyle(
                  fontSize: height / 60,
                  color: Colors.white,
                  fontFamily: 'Tajawal'),
            ),
            selectedColor: buttoncolor,
          ),
          SalomonBottomBarItem(
              icon: Image.asset(
                "assets/orders.png",
                height: height / 40,
                color: _selectedIndex == 1 ? Colors.white : Colors.grey,
              ),
              title: Text(
                tr("mytrips"),
                style: TextStyle(
                    fontSize: height / 60,
                    color: Colors.white,
                    fontFamily: 'Tajawal'),
              ),
              selectedColor: buttoncolor),

          SalomonBottomBarItem(
              icon: Image.asset(
                "assets/chat.png",
                height: height / 40,
                color: _selectedIndex == 2 ? Colors.white : Colors.grey,
              ),
              title: Text(
                tr("mychat"),
                style: TextStyle(
                    fontSize: height / 60,
                    color: Colors.white,
                    fontFamily: 'Tajawal'),
              ),
              selectedColor: buttoncolor),

          SalomonBottomBarItem(

            icon: Image.asset("assets/user.png",
                height: height / 40,
                color: _selectedIndex == 3 ? Colors.white : Colors.grey),
            title: GestureDetector(
              onTap: (){

              },
              child: Text(
                tr("user"),
                style: TextStyle(
                    fontSize: height / 60,
                    color: Colors.white,
                    fontFamily: 'Tajawal'),
              ),
            ),
            selectedColor: buttoncolor,

          ),
        ],
        onTap: (index) {

          setState(() {
            _selectedIndex = index;
            //gotopage(index);
            _pageOption[_selectedIndex];
          });

        },
      ),
      body: _pageOption[_selectedIndex],
    );
  }
}
