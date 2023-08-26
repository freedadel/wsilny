import 'package:flutter/material.dart';
import 'package:wsilny/controllers/auth_controller.dart';
import 'package:wsilny/views/homescreen/home.dart';
import 'package:wsilny/views/msgs/chatpage.dart';
import 'package:wsilny/views/orderscreen/orders.dart';
import 'package:wsilny/views/user/user.dart';
import 'package:wsilny/utils/colornotifire.dart';
import 'package:wsilny/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authscreen/signin.dart';
import 'package:easy_localization/easy_localization.dart';
import '../msgs/messageslist.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            icon: Icon(Icons.home_outlined, color: _selectedIndex == 0 ? Colors.white : buttoncolor,),
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
              icon: Icon(Icons.history_rounded, color: _selectedIndex == 1 ? Colors.white : buttoncolor,),
              title: Text(
                tr("mytrips"),
                style: TextStyle(
                    fontSize: height / 60,
                    color: Colors.white,
                    fontFamily: 'Tajawal'),
              ),
              selectedColor: buttoncolor),

          SalomonBottomBarItem(
              icon: Icon(Icons.textsms_outlined, color: _selectedIndex == 2 ? Colors.white : buttoncolor,),
              title: Text(
                tr("mychat"),
                style: TextStyle(
                    fontSize: height / 60,
                    color: Colors.white,
                    fontFamily: 'Tajawal'),
              ),
              selectedColor: buttoncolor),

          SalomonBottomBarItem(

            icon: Icon(Icons.person_outlined, color: _selectedIndex == 3 ? Colors.white : buttoncolor,),
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
