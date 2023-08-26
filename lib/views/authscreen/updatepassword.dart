import 'package:flutter/material.dart';
import 'package:wsilny/utils/custom_loader.dart';
import 'package:wsilny/views/custtomscreen/appbar.dart';
import 'package:wsilny/views/custtomscreen/button.dart';
import 'package:wsilny/views/custtomscreen/passwordcusttomtextfild.dart';
import 'package:wsilny/routes/route_helper.dart';
import 'package:wsilny/utils/colornotifire.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wsilny/utils/mediaqury.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/../utils/show_custom_snackbar.dart';
import '/../controllers/auth_controller.dart';
import '../custtomscreen/textfild.dart';
import 'package:get/get.dart';
class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
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
    var passwordController = TextEditingController();

    void _updatePassword(){
      String phone = Get.find<AuthController>().phone;
      String password = passwordController.text.trim();

      if(password.isEmpty){
        showCustomSnackBar(tr("fill_password_msg"), title: tr("fill_password"));
      }else{

        Get.find<AuthController>().updatePassword(phone,password).then((status){
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
        appBar: CustomAppBar( tr("forgotpassword")),
        body: GetBuilder<AuthController> (builder: (authController){
          return !authController.isLoading?SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height / 70),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Text(
                      tr("newpassword"),
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
                GestureDetector(
                  onTap: () {
                    _updatePassword();
                  },
                  child: Custombutton.button(
                    tr("save"),
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
