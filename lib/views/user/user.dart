
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:wassilni/controllers/location_controller.dart';
import 'package:wassilni/controllers/auth_controller.dart';
import 'package:wassilni/controllers/user_controller.dart';
import 'package:wassilni/loream.dart';
import 'package:wassilni/utils/app_constants.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:wassilni/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wassilni/utils/mediaqury.dart';
import 'package:wassilni/views/bottomsheet/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '/../routes/route_helper.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {


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
    print("Token: "+AppConstants.TOKEN);
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIN();
    if(_userLoggedIn){

      Get.find<UserController>().getUserInfo();

    return Scaffold(
      backgroundColor: notifier.getwihite,
      body: GetBuilder<UserController>(builder: (userController) {
        print("Logged in " + _userLoggedIn.toString());
        return _userLoggedIn?(userController.isUserLoaded?SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height / 2.5,
                width: width,
                decoration: BoxDecoration(
                  color: buttoncolor.withOpacity(0.10),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: height / 20),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Bottomhome()),
                              );
                              //print("hello");
                            },
                            child: Icon(Icons.arrow_back,
                                color:  notifier.getbuttoncolor, size: height / 30),
                          ),
                          Text(
                            tr("profile"),
                            style: TextStyle(color: notifier.getblack,
                              fontFamily: 'Tajawal',
                              fontSize: height / 35,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getUpdateUser());
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  size: height / 40,
                                  color: const Color(0xfff36a3f),
                                ),
                                Text(
                                  tr("edit"),
                                  style: TextStyle(
                                    color: const Color(0xfff36a3f),
                                    fontSize: height / 50,
                                    fontFamily: 'Tajawal',
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: height / 25),
                    if(userController.userInfo.img == null)
                    Image.asset("assets/profile2.png", height: height / 6.5)
                    else
                    Image.network(
                          AppConstants.BASE_URL+AppConstants.USERS_IMAGES_URI + userController.userInfo.img!,
                          height: height / 6.5
                      ),
                    SizedBox(height: height / 50),
                    Text(
                      userController.userInfo.name,
                      style: TextStyle(
                        color: notifier.getblack,
                        fontSize: height / 30,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    // SizedBox(height: height/100),
                    Text(
                      userController.userInfo.phone,
                      style: TextStyle(
                        color: notifier.getbuttoncolor,
                        fontSize: height / 50,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height / 35),


              GestureDetector(
                onTap: () {
                  share();
                },
                child: profiletype(tr("invitefriend"), "assets/AddUser.png"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 20),
                child: const Divider(
                  color: Color(0xffE0E0E0),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Loream(tr("help")),
                      ),
                    );
                  },
                  child: profiletype(tr("help"), "assets/helps.png")),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 20),
                child: const Divider(
                  color: Color(0xffE0E0E0),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getSettings());
                },
                child: profiletype(tr("setting"), "assets/Settings.png"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 20),
                child: const Divider(
                  color: Color(0xffE0E0E0),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if(Get.find<AuthController>().userLoggedIN()){
                    Get.find<AuthController>().clearSharedData();
                    Get.find<LocationController>().clearAddressList();
                    //MaterialPageRoute(builder: (context) => const SignIn());
                    Get.offNamed(RouteHelper.getLogin());
                  }
                },
                child: profiletype(tr("logout"), "assets/Logouts.png"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 20),
                child: const Divider(
                  color: Color(0xffE0E0E0),
                ),
              ),
            ],
          ),
        ):
        CircularProgressIndicator()):
        Container(child: Center(child: Text("You must login"),),);
      },),
    );
    }else{
      return Scaffold();
    }
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  Widget profiletype(name, image) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(width: width / 20),
          CircleAvatar(
            backgroundColor: notifier.getbuttoncolor.withOpacity(0.10),
            child: Image.asset(image,
                height: height / 40, color: notifier.getbuttoncolor),
          ),
          SizedBox(width: width / 50),
          Text(
            name,
            style: TextStyle(
              color: notifier.getblack,
              fontSize: height / 50,
              fontFamily: 'Tajawal',
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: height / 40,
            color: const Color(0xffE0E0E0),
          ),
          SizedBox(width: width / 20),
        ],
      ),
    );
  }

  Widget profiletype2(name, image,int num) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(width: width / 20),
          CircleAvatar(
            backgroundColor: notifier.getbuttoncolor.withOpacity(0.10),
            child: Image.asset(image,
                height: height / 40, color: notifier.getbuttoncolor),
          ),
          SizedBox(width: width / 50),
          Text(
            name,
            style: TextStyle(
              color: notifier.getblack,
              fontSize: height / 50,
              fontFamily: 'Tajawal',
            ),
          ),
          if(num > 0)
          Stack(
            children: [
            Positioned(child:
            Icon(
              Icons.circle,
              size: height / 25,
              color: Colors.red,
            )),
              Positioned(
                top: 10,
                  right: 10,
                  child:Text(num.toString(),selectionColor: Colors.white,)
              ),

          ]),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: height / 40,
            color: const Color(0xffE0E0E0),
          ),
          SizedBox(width: width / 20),
        ],
      ),
    );
  }

  Widget darkmode(name) {
    return Container(
      color: Colors.transparent,

    );
  }
}
