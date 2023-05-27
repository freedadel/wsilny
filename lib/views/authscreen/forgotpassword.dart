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
class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
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

    void _verify(){
      String phone = phoneController.text.trim();

      if(phone.isEmpty){
        showCustomSnackBar(tr("fill_phone_msg"), title: tr("fill_phone"));
      }else if(phone.length != 10){
        showCustomSnackBar(tr("phone_length_msg"), title: tr("phone_length"));
      }else{

        Get.find<AuthController>().verify(phone).then((status){
          if(status.isSuccess){
            //Navigator.pop(context);
            Get.toNamed(RouteHelper.getUpdatePassword());
          }else{
            //showCustomSnackBar(status.message);
            showCustomSnackBar(tr("notverified"));
          }
        });
      }
    }
    return Scaffold(
        backgroundColor: notifier.getwihite,
        appBar: CustomAppBar( tr("forgotpassword")),
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
                GestureDetector(
                  onTap: () {
                    _verify();
                  },
                  child: Custombutton.button(
                    tr("verify"),
                    width / 1.1,
                    Colors.transparent,
                    notifier.getbuttoncolor,
                    notifier.getwihite,
                  ),
                ),
                SizedBox(height: height / 50),
              ],
            ),
          ):CustomLoader();
        })
    );
  }
}
