import 'package:flutter/material.dart';
import 'package:wassilni/utils/custom_loader.dart';
import 'package:wassilni/views/custtomscreen/appbar.dart';
import 'package:wassilni/views/custtomscreen/button.dart';
import 'package:wassilni/views/custtomscreen/passwordcusttomtextfild.dart';
import 'package:wassilni/routes/route_helper.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wassilni/utils/mediaqury.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/../utils/show_custom_snackbar.dart';
import '/../controllers/auth_controller.dart';
import '../custtomscreen/textfild.dart';
import 'package:get/get.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
  late ColorNotifier notifier;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if(phone.isEmpty){
        showCustomSnackBar(tr("fill_phone_msg"), title: tr("fill_phone"));
      }else if(phone.length != 10){
        showCustomSnackBar(tr("phone_length_msg"), title: tr("phone_length"));
      }else if(password.isEmpty){
        showCustomSnackBar(tr("fill_password_msg"), title: tr("fill_password"));
      }else{

        authController.login(phone,password).then((status){
          if(status.isSuccess){
            //Navigator.pop(context);
            Get.toNamed(RouteHelper.getInitial());
          }else{
            //showCustomSnackBar(status.message);
            showCustomSnackBar(tr("wrong_password"));
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: notifier.getwihite,
      appBar: CustomAppBar( tr("signin")),
      body: GetBuilder<AuthController> (builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: width / 20),
                  Text(
                    tr("loginwithyouraccount"),
                    style: TextStyle(
                      color:  notifier.getgreay,
                      fontFamily: 'Tajawal',
                      fontSize: height / 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 30),
              Row(
                children: [
                  SizedBox(width: width / 20),
                  Text(
                    tr("phone"),
                    style: TextStyle(
                      color: notifier.getgreay,
                      fontFamily: 'Tajawal',
                      fontSize: height / 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 100),
              CusttomTextfild(tr("phoneNumber"),phoneController),
              SizedBox(height: height / 70),
              Row(
                children: [
                  SizedBox(width: width / 20),
                  Text(
                    tr("password"),
                    style: TextStyle(
                      color: notifier.getgreay,
                      fontFamily: 'Tajawal',
                      fontSize: height / 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 100),
              PasswordCusttomTextfild(tr("password"),passwordController),
              SizedBox(height: height / 200),
              Row(
                children: [
                  SizedBox(width: width / 1.7),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getForgot());
                    },
                    child: Text(
                      tr("forgotpassword"),
                      style: TextStyle(
                        color: notifier.getbuttoncolor,
                        fontFamily: 'Tajawal',
                        fontSize: height / 50,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: height/3.3),
              GestureDetector(
                onTap: () {
                  _login(authController);
                },
                child: Custombutton.button(
                  tr("login"),
                  width / 1.1,
                  Colors.transparent,
                  notifier.getbuttoncolor,
                  notifier.getwihite,
                ),
              ),
              SizedBox(height: height / 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr("donthaveanaccountyet"),
                    style: TextStyle(
                      color: notifier.getblack,
                      fontSize: height / 55,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getUsertype());
                    },
                    child: Text(
                      tr("register"),
                      style: TextStyle(
                        color:  notifier.getbuttoncolor,
                        fontSize: height / 55,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 25)
            ],
          ),
        ):CustomLoader();
      })
    );
  }
}
