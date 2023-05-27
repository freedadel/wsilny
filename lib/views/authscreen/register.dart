import 'package:flutter/material.dart';
import 'package:wassilni/Models/sign_up_body.dart';
import 'package:wassilni/utils/custom_loader.dart';
import 'package:wassilni/utils/show_custom_snackbar.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:wassilni/utils/mediaqury.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '/../controllers/auth_controller.dart';
import '../custtomscreen/appbar.dart';
import '../custtomscreen/button.dart';
import '../custtomscreen/passwordcusttomtextfild.dart';
import '../custtomscreen/textfild.dart';
import '/../routes/route_helper.dart';
import 'package:easy_localization/easy_localization.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

bool isChecked = false;

class _RegisterState extends State<Register> {
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
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    var passwordController = TextEditingController();



    void _registration(AuthController authController){
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
          showCustomSnackBar("Type in your name", title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone", title: "Phone");
      }else if(phone.length != 10){
        showCustomSnackBar("Phone can't be less than 10 characters", title: "Name");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");
      }else{

        SignUpBody signUpBody = SignUpBody(name: name,phone: phone,password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
              print("Success registration");
          }else{
              showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor:  notifier.getwihite,
      appBar: CustomAppBar(  tr("register")),
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: width / 20),
                  Text(
                    tr("createanaccounttostart"),
                    style: TextStyle(
                      color: notifier.getgreay,
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
                    tr("name"),
                    style: TextStyle(
                      color: notifier.getgreay,
                      fontFamily: 'Tajawal',
                      fontSize: height / 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 100),
              CusttomTextfild(tr("yourfullname"), nameController),
              SizedBox(height: height / 70),
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
              SizedBox(height: height / 200),
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
              Text(
                tr("passwordmustcontainsofcharacter"),
                style: TextStyle(
                  color: notifier.getgreay,
                  fontFamily: 'Tajawal',
                  fontSize: height / 58,
                ),
              ),
              SizedBox(height: height / 70),
              /*
              Row(
                children: [
                  Transform.scale(
                    scale: 1,
                    child: Checkbox(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      activeColor:  notifier.getbuttoncolor,
                      side: BorderSide(color:  notifier.getbuttoncolor,),
                      value: isChecked,
                      splashRadius: 1,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            tr("bysigningupiagreetothe,
                            style: TextStyle(
                                color: notifier.getblack,
                                fontSize: height / 62,
                                fontFamily: 'Tajawal'),
                          ),
                          Text(
                            tr("termcondition,
                            style: TextStyle(
                                color:  notifier.getbuttoncolor,
                                fontSize: height / 62,
                                fontFamily: 'Tajawal'),
                          ),
                          Text(
                            tr("and,
                            style: TextStyle(
                                color: notifier.getblack,
                                fontSize: height / 62,
                                fontFamily: 'Tajawal'),
                          ),
                        ],
                      ),
                      Text(
                        tr("privacypolicy,
                        style: TextStyle(
                            color:  notifier.getbuttoncolor,
                            fontSize: height / 62,
                            fontFamily: 'Tajawal'),
                      ),
                    ],
                  ),
                ],
              ),

               */
              SizedBox(height: height / 10),


              GestureDetector(
                onTap: () {
                  _registration(_authController);
                    Get.toNamed(RouteHelper.getInitial());
                },
                child: Custombutton.button(
                  tr("createaccount"),
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
                    tr("alredyhaveanacount"),
                    style: TextStyle(
                      color: notifier.getblack,
                      fontSize: height / 55,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getLogin());
                    },
                    child: Text(
                      tr("signin"),
                      style: TextStyle(
                        color:  notifier.getbuttoncolor,
                        fontSize: height / 55,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ):const CustomLoader();
      },)
    );


  }
}
