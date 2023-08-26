import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wsilny/controllers/auth_controller.dart';
import 'package:wsilny/controllers/orders_controller.dart';
import 'package:wsilny/controllers/user_controller.dart';
import 'package:wsilny/utils/colornotifire.dart';
import 'package:wsilny/utils/mediaqury.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:wsilny/Models/orders_model.dart';
import 'package:wsilny/controllers/ads_controller.dart';
import 'package:wsilny/routes/route_helper.dart';
import 'package:wsilny/utils/show_custom_snackbar.dart';
import '../../controllers/messages_controller.dart';
import '../../utils/colors.dart';
import '../custtomscreen/button.dart';
import '../custtomscreen/textfild.dart';
import 'package:wsilny/utils/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String dropdownvalue = "";
  int _groupValue = 0;
  int _typeValue = 0;
  var changed = false;
  double lat=0;
  double long=0;


  List shopcatogeryimagelist = [
    "assets/car.png",
    "assets/carton.png",
  ];

  List catogeryname = [
    tr("trip"),
    tr("charge"),
  ];


  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previusstate;
    }
  }
  var fromController = TextEditingController();
  var toController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdarkmodepreviousstate();
    //String? token = await FirebaseMessaging.instance.getToken();
    //print(token);

  }
late ColorNotifier notifier;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    void saveOrder() {
      OrdersController ordersController = Get.find<OrdersController>();

      String from = fromController.text.trim();
      String to = toController.text.trim();
      getCurrentData();
      if (from.isEmpty) {
        showCustomSnackBar(tr("order_from_msg"), title: tr("order_from"));
      }else if (to.isEmpty) {
        showCustomSnackBar(tr("order_to_msg"), title: tr("order_to"));
      }else {
        OrderModel orderModel = OrderModel(
            from: from,
            to: to,
            lat: lat,
            long: long,
            gender: _groupValue,
            type: _typeValue
        );
        ordersController.saveOrder(orderModel).then((status) {
          print("Send to Controller");
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getOrderDone());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    Future.delayed(const Duration(seconds: 10));
    getCurrentData();
    if(Get.find<AuthController>().userLoggedIN()) {
      try{
        Get.find<UserController>().updateLatLong(lat, long);
      }catch (ex){
        print(ex);
      }

    }

    return Scaffold(
      backgroundColor: notifier.getwihite,

      body: SingleChildScrollView(
        child:
        AppConstants.PERMISSION == "3"?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height / 20),

            if(Get.find<AuthController>().userLoggedIN())
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: width / 20),
                      Text(
                        tr("hello"),
                        style: TextStyle(
                          color: notifier.getblack,
                          fontFamily: 'Tajawal',
                          fontSize: height / 30,
                        ),
                      ),
                      SizedBox(width: width / 70),

                     Text(
                        AppConstants.USERNAME,
                        style: TextStyle(
                          color:  notifier.getbuttoncolor,
                          fontFamily: 'Tajawal',
                          fontSize: height / 30,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            SizedBox(height: height / 130),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  tr("latestoffers"),
                  style: TextStyle(
                    color: notifier.getblack,
                    fontFamily: 'Tajawal',
                    fontSize: height / 50,
                  ),
                )
              ],
            ),

            ads(),
            SizedBox(height: height / 150),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  tr("bookNow"),
                  style: TextStyle(
                    color: notifier.getgreay,
                    fontFamily: 'Tajawal',
                    fontSize: height / 50,
                  ),
                ),
              ],
            ),

            /*
            SizedBox(height: height / 90),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  tr("tripFrom"),
                  style: TextStyle(
                    color: notifier.getgreay,
                    fontFamily: 'Tajawal',
                    fontSize: height / 55,
                  ),
                ),
              ],
            ),
            */
            SizedBox(height: height / 130),
            CusttomTextfild(tr("tripFrom"), fromController),
            /*
            SizedBox(height: height / 120),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  tr("tripTo"),
                  style: TextStyle(
                    color: notifier.getgreay,
                    fontFamily: 'Tajawal',
                    fontSize: height / 55,
                  ),
                ),
              ],
            ),

             */
            SizedBox(height: height / 130),
            CusttomTextfild(tr("tripTo"), toController),
            SizedBox(height: height / 130),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                typeselect(tr("passengers"), 0),
                SizedBox(width: width / 50),
                typeselect(tr("shipping"), 1),
              ],
            ),
            SizedBox(height: height / 130),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                genderselect(tr("male"), 0),
                SizedBox(width: width / 50),
                genderselect(tr("female"), 1),
              ],
            ),
            SizedBox(height: height / 30),
            GestureDetector(
              onTap: () {
                  saveOrder();
              },
              child: Custombutton.button(
                tr("wsilny"),
                width / 1.1,
                Colors.transparent,
                notifier.getbuttoncolor,
                notifier.getwihite,
              ),
            ),

          ],
        ):
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height / 30),

            if(Get.find<AuthController>().userLoggedIN())
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: width / 20),
                      Text(
                        tr("hello"),
                        style: TextStyle(
                          color: notifier.getblack,
                          fontFamily: 'Tajawal',
                          fontSize: height / 30,
                        ),
                      ),
                      SizedBox(width: width / 70),

                      Text(
                        AppConstants.USERNAME,
                        style: TextStyle(
                          color:  notifier.getbuttoncolor,
                          fontFamily: 'Tajawal',
                          fontSize: height / 30,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            SizedBox(height: height / 130),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  tr("latestoffers"),
                  style: TextStyle(
                    color: notifier.getblack,
                    fontFamily: 'Tajawal',
                    fontSize: height / 50,
                  ),
                )
              ],
            ),

            ads(),
            SizedBox(height: height / 130),


            GetBuilder<OrdersController>(
              builder: (controller) => controller.isLoaded?
                  controller.qordersList.length > 0?
                 SizedBox(
                  child: Container(
                    color: Colors.transparent,
                    child: SizedBox(
                        width: width / 1.1,
                        child: GetBuilder<OrdersController>(builder: (qOrdersList){
                          //ordersList.getOrderList();
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: qOrdersList.qordersList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () async {
                                      if (await confirm(
                                        context,
                                        title: const Text('التأكيد'),
                                        content: const Text('مراسلة صاحب الطلب؟'),
                                        textOK: const Text('مراسلة'),
                                        textCancel: const Text('الغاء'),
                                      )) {
                                        return (Get.find<MessagesController>().getMSGDetails(qOrdersList.qordersList[index].customer_id.toString()).then((status) {
                                                print("Send Message to Controller");
                                                if (status.isSuccess) {
                                                Get.toNamed(RouteHelper.getChatPage(qOrdersList.qordersList[index].customer_id));
                                                } else {
                                                showCustomSnackBar(status.message);
                                                }}));
                                      }
                                      print("الغاء");
                                    },
                                    child:Padding(
                                      padding: const EdgeInsets.all(5.5),
                                      child: orderBox("طلب رحلة رقم ${qOrdersList.qordersList[index].id}", qOrdersList.qordersList[index].from+" الى "+
                                          qOrdersList.qordersList[index].to,
                                          qOrdersList.qordersList[index].createdAt.toString().substring(0,10)),
                                    ));
                              }
                          );})),
                  ),
                ):
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height/8),
                          child: Icon(Icons.remove_from_queue_outlined,size: height/8,),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("لا يوجد طلبات حالياً",textScaleFactor: 1.5,),
                        ),
                      ],
                    ),
                  )
                  :const Center(child: CircularProgressIndicator(),),
            )
          ],
        )
      ),
    );
  }

  Widget orderBox(id, fromTo, orderdate) {
    return GestureDetector(
      child: Container(
        height: height / 9,
        width: width / 1.1,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          ),
          border: Border.all(color: const Color(0xffE0E0E0),),
        ),
        child: Row(
          children: [
            SizedBox(width: width / 23),
            Image.asset("assets/car2.png", height: height / 15),
            SizedBox(width: width / 23),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height / 60),
                Text(
                  id,
                  style: TextStyle(
                    color: notifier.getgreay,
                    fontSize: height / 55,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: height / 150),
                Text(
                  fromTo,
                  style: TextStyle(
                    color: notifier.getblack,
                    fontSize: height / 45,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: height / 150),
                Text(
                  orderdate,
                  style: TextStyle(
                    color: notifier.getgreay,
                    fontSize: height / 55,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: height / 100),
                Text(
                  "",
                  style: TextStyle(
                    color: notifier.getblack,
                    fontSize: height / 40,
                    fontFamily: 'Tajawal',
                  ),
                ),
                Text(
                  "",
                  style: TextStyle(
                    color: notifier.getgreay,
                    fontSize: height / 55,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
            SizedBox(width: width / 25),
          ],
        ),
      ),
    );
  }

  Widget catogery() {
    return Container(
      color: Colors.transparent,
      height: height / 10,
      width: width / 1.1,
      child: ListView.builder(
        itemCount: shopcatogeryimagelist.length,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: width / 60),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (index == 0) {

                    } else if (index == 1) {

                    }
                  },
                  child: Container(
                    height: height / 15,
                    width: width / 3,
                    decoration: BoxDecoration(
                      color: index == 0
                          ? const Color(0xfffbf0e8)
                          : index == 1
                              ? const Color(0xffd1eaf7)
                              : const Color(0xffd2f1db),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(18),
                      ),
                      // border: Border.all(color: const Color(0xffE0E0E0)),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(width: width / 30),
                          Container(
                            height: height / 20,
                            width: width / 11,
                            decoration: BoxDecoration(
                              color: notifier.getwihite,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(shopcatogeryimagelist[index],color: notifier.getblack,
                                  height: height / 40),
                            ),
                          ),
                          SizedBox(width: width / 35),
                          Expanded(
                            child: Text(
                              catogeryname[index],
                              style: TextStyle(color: Colors.black,
                                fontSize: height / 55,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                          SizedBox(width: width / 50),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget genderselect(gender, val) {
    return GestureDetector(
      onTap: () {
        setState(
              () {
            _groupValue = val as int;
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
            Radio(
              activeColor: buttoncolor,
              value: val as int,
              groupValue: _groupValue,
              onChanged: (value) {
                setState(() {
                  _groupValue = value as int;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget typeselect(gender, val) {
    return GestureDetector(
      onTap: () {
        setState(
              () {
            _typeValue = val as int;
          },
        );
      },
      child: Container(
        height: height / 16,
        width: width / 2.3,
        decoration: BoxDecoration(
          border: Border.all(
              color: _typeValue == val ? buttoncolor : Colors.transparent,
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
            Radio(
              activeColor: buttoncolor,
              value: val as int,
              groupValue: _typeValue,
              onChanged: (value) {
                setState(() {
                  _typeValue = value as int;
                });
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget ads() {
    return Container(
        color: Colors.transparent,
        height: height / 4,
        width: width / 1,
        child: GetBuilder<AdsController>(builder: (allAdsList){
          return allAdsList.isLoaded?CarouselSlider.builder(
            options: CarouselOptions(
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              autoPlay: true,
            ),
            itemCount: allAdsList.adsList.length,
            itemBuilder: (context, index,realIdx) {
              return Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width / 80),
                    child: Container(
                      color: Colors.transparent,
                      height: height / 5,
                      width: width / 1.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          AppConstants.BASE_URL + AppConstants.ADS_IMAGES_URI + allAdsList.adsList[index].img.toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ):const CircularProgressIndicator(
            color: Colors.white,
          );
        }
          ,)
    );
  }

  Future<Position> getLatLong() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getCurrentData() async {
    Position position = await getLatLong();
    lat = position.latitude;
    long = position.longitude;
  }

}
