import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wassilni/controllers/user_controller.dart';
import 'package:wassilni/utils/app_constants.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:wassilni/utils/colors.dart';
import 'package:wassilni/utils/mediaqury.dart';
import 'package:wassilni/utils/show_custom_snackbar.dart';
import 'package:wassilni/utils/widgets/app_icon.dart';
import 'package:wassilni/views/custtomscreen/button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'controllers/orders_controller.dart';
class Loream extends StatefulWidget {

  final String? titles;
  const  Loream(this.titles, {Key? key}) : super(key: key);

  @override
  State<Loream> createState() => _LoreamState();
}

class _LoreamState extends State<Loream> {
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
  var describtionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdarkmodepreviousstate();
  }
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);

    void save(){
      String describtion = describtionController.text.trim();
        if (describtion.isEmpty) {
          showCustomSnackBar(tr("pt_description_msg"), title: tr("pt_description"));
        } else {
          Get.find<UserController>().sendComment(describtion);
        }
      }

    return Scaffold(
      backgroundColor: notifier.getwihite,
      body: Column(
        children: [
          SizedBox(height: height / 14),
          Row(
            children: [
              SizedBox(width: width / 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back,
                    size: height / 30, color: notifier.getbuttoncolor),
              ),
              const Spacer(),
              Text(
                widget.titles!,
                style: TextStyle(
                  color: notifier.getblack,
                  fontSize: height / 40,
                  fontFamily: 'Tajawal',
                ),
              ),
              SizedBox(width: width / 2.3),
            ],
          ),
          SizedBox(height: height / 50),
          Center(
            child: Container(
              width: width / 1.1,

              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffE0E0E0),
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                      width: width / 1.1,
                      child: GetBuilder<OrdersController>(builder: (ordersController){

                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              if(index == 0){
                                return Container(
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        SizedBox(width: width / 50),
                                        AppIcon(icon: Icons.mail),
                                        SizedBox(width: width / 30),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: height / 32),
                                            Text(
                                              "info@test.com",
                                              style: TextStyle(
                                                color: notifier.getblack,
                                                fontSize: height / 60,
                                                fontFamily: 'Tajawal',
                                              ),
                                            ),
                                            SizedBox(height: height / 200),
                                            Text(
                                              "mail",
                                              style: TextStyle(
                                                color: notifier.getgreay,
                                                fontSize: height / 50,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),

                                        SizedBox(width: width / 20),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              else{
                                return Container(
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        SizedBox(width: width / 50),
                                        AppIcon(icon: Icons.phone),
                                        SizedBox(width: width / 30),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: height / 32),
                                            Text(
                                              "9665XXXXXXX",
                                              style: TextStyle(
                                                color: notifier.getblack,
                                                fontSize: height / 60,
                                                fontFamily: 'Tajawal',
                                              ),
                                            ),
                                            SizedBox(height: height / 200),
                                            Text(
                                              "phone",
                                              style: TextStyle(
                                                color: notifier.getgreay,
                                                fontSize: height / 50,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),

                                        SizedBox(width: width / 20),
                                      ],
                                    ),
                                  ),
                                );
                              }

                            }

                        );
                      })),
                  SizedBox(height: height / 20),
                  Row(
                    children: [
                      SizedBox(width: width / 20),
                      Text(
                        tr("sendtous"),
                        style: TextStyle(
                          color: notifier.getgreay,
                          fontFamily: 'Tajawal',
                          fontSize: height / 55,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 80),
                  discription(describtionController),
                  SizedBox(height: height / 80),
                  GestureDetector(
                    onTap: () {
                      save();
                    },
                    child: Custombutton.button(
                      tr("send"),
                      width / 1.2,
                      Colors.transparent,
                      notifier.getbuttoncolor,
                      notifier.getwihite,
                    ),
                  ),
                  SizedBox(height: height / 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget discription(TextEditingController textEditingController) {
    return Container(
      color: Colors.transparent,
      height: height / 5,
      width: width / 1.2,
      child: TextField(
        style: TextStyle(color: notifier.getblack),
        maxLines: 10,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20,right: 20, top: 30),
          hintText: tr("writehere"),
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

}
