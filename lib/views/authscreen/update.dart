

import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:wassilni/Models/sign_up_body.dart';
import 'package:wassilni/controllers/user_controller.dart';
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
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

bool isChecked = false;

class _UpdateState extends State<Update> {
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
  PickedFile? imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdarkmodepreviousstate();
  }
  @override
  Widget build(BuildContext context) {
    var userInfo = Get.find<UserController>().userInfo;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    var passwordController = TextEditingController();

    nameController.text = userInfo.name;
    phoneController.text = userInfo.phone;


    void _registration(AuthController authController){
      String img = base64Encode(File(imageFile!.path).readAsBytesSync());
      String imgname = File(imageFile!.path).path.split("/").last;
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
          showCustomSnackBar("Type in your name", title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone", title: "Phone");
      }else if(phone.length != 10){
        showCustomSnackBar("Phone can't be less than 10 characters", title: "Name");
      }else{

        SignUpBody signUpBody = SignUpBody(name: name,phone: phone,password: password,img:img,imgname:imgname);
        authController.updateUser(signUpBody).then((status){
          if(status.isSuccess){
              print("Success update");
          }else{
              showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor:  notifier.getwihite,
      appBar: CustomAppBar(  tr("updateUser")),
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: width / 20),
                  Text(
                    tr("updateyourdata"),
                    style: TextStyle(
                      color: notifier.getgreay,
                      fontFamily: 'Tajawal',
                      fontSize: height / 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 80),
              addphoto(),
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
                  tr("updateNow"),
                  width / 1.1,
                  Colors.transparent,
                  notifier.getbuttoncolor,
                  notifier.getwihite,
                ),
              ),

            ],
          ),
        ):const CustomLoader();
      },)
    );
  }
  Widget addphoto() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _openCamera(context);
              });
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: Container(
                child: (imageFile == null)
                    ? DottedBorder(
                  strokeWidth: 5,
                  dashPattern: const [6, 6, 6, 6],
                  borderType: BorderType.RRect,
                  color: const Color(0xffc5c5c5),
                  radius: const Radius.circular(20),
                  child: Container(
                    height: height / 4.3,
                    width: width / 1.1,
                    color: notifier.getnewpetcolor,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.camera_alt,
                              color: Color(0xffc5c5c5)),
                          SizedBox(width: width / 40),
                          Text(
                            tr("addphoto"),
                            style: TextStyle(
                              color: const Color(0xffc5c5c5),
                              fontFamily: 'Tajawal',
                              fontSize: height / 50,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                    : DottedBorder(
                  strokeWidth: 5,
                  dashPattern: const [6, 6, 6, 6],
                  borderType: BorderType.RRect,
                  color: const Color(0xffc5c5c5),
                  radius: const Radius.circular(20),
                  child: Container(
                    height: height / 4.3,
                    width: width / 1.1,
                    color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Image.file(
                        File(
                          imageFile!.path,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openCamera(BuildContext context) async {
    PickedFile? file = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    // final pickedFile = await ImagePicker().getImage(
    //   source: ImageSource.gallery,
    // );
    setState(() {
      imageFile = file!;
    });
  }
}
