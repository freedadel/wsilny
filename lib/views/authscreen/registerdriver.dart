import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wsilny/Models/sign_up_body.dart';
import 'package:wsilny/utils/custom_loader.dart';
import 'package:wsilny/utils/show_custom_snackbar.dart';
import 'package:wsilny/utils/colornotifire.dart';
import 'package:wsilny/utils/mediaqury.dart';
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
import 'dart:io';

class Registerdriver extends StatefulWidget {
  const Registerdriver({Key? key}) : super(key: key);

  @override
  State<Registerdriver> createState() => _RegisterdriverState();
}

bool isChecked = false;

class _RegisterdriverState extends State<Registerdriver> {
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

  PickedFile? imageFileLicense;
  PickedFile? imageFileCarLicense;
  PickedFile? imageFileCarImg;
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdarkmodepreviousstate();
  }
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);




    void _registration(AuthController authController){
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      String carimg = base64Encode(File(imageFileCarImg!.path).readAsBytesSync());
      String carimgname = File(imageFileCarImg!.path).path.split("/").last;

      String licenseimg = base64Encode(File(imageFileLicense!.path).readAsBytesSync());
      String licenseimgname = File(imageFileLicense!.path).path.split("/").last;

      String carlicenseimg = base64Encode(File(imageFileCarLicense!.path).readAsBytesSync());
      String carlicenseimgname = File(imageFileCarLicense!.path).path.split("/").last;

      if(name.isEmpty){
          showCustomSnackBar("Type in your name", title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone", title: "Phone");
      }else if(phone.length != 10){
        showCustomSnackBar("Phone can't be less than 10 characters", title: "Name");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");
      }else{

        SignUpBody signUpBody = SignUpBody(name: name,phone: phone,password: password,
            carimg: carimg,
            carimgname: carimgname,
            licenseimg: licenseimg,
            licenseimgname: licenseimgname,
            carlicenseimg: carlicenseimg,
            carlicenseimgname: carlicenseimgname,

        );
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
              SizedBox(height: height / 80),
              addphotolicense(),
              SizedBox(height: height / 80),
              addphotocarlicense(),
              SizedBox(height: height / 80),
              addphotocarimg(),
              SizedBox(height: height / 70),

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
  Widget addphotolicense() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _openCameraLicense(context);
              });
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: Container(
                child: (imageFileLicense == null)
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
                            tr("addphotolicense"),
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
                          imageFileLicense!.path,
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

  Widget addphotocarlicense() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _openCameraCarLicense(context);
              });
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: Container(
                child: (imageFileCarLicense == null)
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
                            tr("addphotocarlicense"),
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
                          imageFileCarLicense!.path,
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

  Widget addphotocarimg() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _openCameraCarImg(context);
              });
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: Container(
                child: (imageFileCarImg == null)
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
                            tr("addphotocarimg"),
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
                          imageFileCarImg!.path,
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

  void _openCameraLicense(BuildContext context) async {
    PickedFile? file = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    // final pickedFile = await ImagePicker().getImage(
    //   source: ImageSource.gallery,
    // );
    setState(() {
      imageFileLicense = file!;
    });
  }

  void _openCameraCarLicense(BuildContext context) async {
    PickedFile? file = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    // final pickedFile = await ImagePicker().getImage(
    //   source: ImageSource.gallery,
    // );
    setState(() {
      imageFileCarLicense = file!;
    });
  }

  void _openCameraCarImg(BuildContext context) async {
    PickedFile? file = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    // final pickedFile = await ImagePicker().getImage(
    //   source: ImageSource.gallery,
    // );
    setState(() {
      imageFileCarImg = file!;
    });
  }

}
