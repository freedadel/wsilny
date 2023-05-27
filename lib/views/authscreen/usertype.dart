
import 'package:flutter/material.dart';
import 'package:wassilni/controllers/settings_controller.dart';
import 'package:wassilni/routes/route_helper.dart';
import 'package:wassilni/views/custtomscreen/button.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:wassilni/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wassilni/utils/mediaqury.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
class Usertype extends StatefulWidget {
  const Usertype({Key? key}) : super(key: key);

  @override
  State<Usertype> createState() => _Usertype();
}

class _Usertype extends State<Usertype> {


  String _groupValue = "العربية";
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
    _groupValue = tr("customer");

    void _saveSettings() {
      var settingsController = Get.find<SettingsController>();
      settingsController.setLanguage(_groupValue.toString());
      if(_groupValue.toString() == "English"){
        context.setLocale(const Locale('en', 'US'));
        Get.updateLocale(const Locale('en', 'US'));
      }else{
        context.setLocale(const Locale('ar', 'DZ'));
        Get.updateLocale(const Locale('ar', 'DZ'));
      }
    }



    return Scaffold(
        backgroundColor: notifier.getwihite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height / 17),
              Row(
                children: [
                  SizedBox(width: width / 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: height / 30,
                      color: notifier.getbuttoncolor,
                    ),
                  )
                ],
              ),
              SizedBox(height: height / 50),
              Row(
                children: [
                  SizedBox(width: width / 20),
                  Text(
                    tr("newUser"),
                    style: TextStyle(
                      color: notifier.getblack,
                      fontFamily: 'Tajawal',
                      fontSize: height / 25,
                    ),
                  )
                ],
              ),

              SizedBox(height: height / 30),
              Row(
                children: [
                  SizedBox(width: width / 20),
                  Text(
                    tr("usertype"),
                    style: TextStyle(
                      color: notifier.getgreay,
                      fontFamily: 'Tajawal',
                      fontSize: height / 55,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genderselect(tr("customer"), "1"),
                  SizedBox(width: width / 50),
                  genderselect(tr("driver"), "2"),
                ],
              ),

              SizedBox(height: height / 20),
            ],
          ),

        ));
  }

  Widget discription(TextEditingController textEditingController) {
    return Container(
      color: Colors.transparent,
      height: height / 5,
      width: width / 1.1,
      child: TextField(
        style: TextStyle(color: notifier.getblack),
        maxLines: 10,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20, top: 30),
          hintText: tr("shareabouthestory"),
          hintStyle: TextStyle(
            color: greay,
            fontFamily: 'Tajawal',
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffE0E0E0),
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffE0E0E0),
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        controller: textEditingController,
      ),
    );
  }

  Widget genderselect(gender, val) {
    return GestureDetector(
      onTap: () {
        setState(
              () {
                if(val == "1"){
                  Get.toNamed(RouteHelper.getRegister());
                }else{
                  Get.toNamed(RouteHelper.getRegisterDriver());
                }
            //_groupValue = val! as String;
          },
        );
      },
      child: Container(
        height: height / 16,
        width: width / 2.3,
        decoration: BoxDecoration(
          border: Border.all(
              color: _groupValue == val ? buttoncolor : Colors.transparent,
              width: 2),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: buttoncolor.withOpacity(0.10),
        ),
        child: Row(
          children: [
            SizedBox(width: width / 20),
            Text(
              gender,
              style: TextStyle(
                  color: notifier.getblack,
                  fontSize: height / 50,
                  fontFamily: 'Tajawal'),
            ),
            const Spacer(),
            /* Radio(
              activeColor: buttoncolor,
              value: val as String,
              groupValue: _groupValue,
              onChanged: (value) {
                setState(() {
                  _groupValue = value as String;
                });
              },
            ),

             */
          ],
        ),
      ),
    );
  }

}
