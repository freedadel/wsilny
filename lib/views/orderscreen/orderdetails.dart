import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/orders_controller.dart';
import '../../utils/app_constants.dart';
import '/../utils/mediaqury.dart';
import 'package:get/get.dart';

class OrderDetails extends StatelessWidget {
  int pageId;
  OrderDetails({Key? key,required this.pageId}) : super(key: key);


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
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getwihite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,
                      color:  notifier.getbuttoncolor, size: height / 30),
                ),
                // const Spacer(),
                // Icon(Icons.shopping_basket,
                //     color: buttoncolor, size: height / 30),

              ],
            ),
            SizedBox(height: height / 70),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  tr("orderdetails"),
                  style:
                  TextStyle(fontFamily: 'Tajawal', fontSize: height / 30,color: notifier.getblack),
                ),
              ],
            ),
            SizedBox(height: height / 40),

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
                              itemCount: ordersController.itemsList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        SizedBox(width: width / 50),
                                        Image.network(AppConstants.BASE_URL + AppConstants.PRODUCTS_IMAGES_URI + ordersController.itemsList[index].img.toString()
                                          ,height: height/30,),
                                        SizedBox(width: width / 30),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: height / 32),
                                            Text(
                                              ordersController.itemsList[index].name!.length > 30?"${ordersController.itemsList[index].name.toString().substring(0,30)}..":ordersController.itemsList[index].name.toString(),
                                              style: TextStyle(
                                                color: notifier.getblack,
                                                fontSize: height / 60,
                                                fontFamily: 'Tajawal',
                                              ),
                                            ),
                                            SizedBox(height: height / 200),
                                            Text(
                                              ordersController.itemsList[index].quantity.toString(),
                                              style: TextStyle(
                                                color: notifier.getgreay,
                                                fontSize: height / 50,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${double.parse(ordersController.itemsList[index].price!) * ordersController.itemsList[index].quantity!} SR",
                                          style: TextStyle(
                                            fontFamily: 'Tajawal',
                                            color: notifier.getgreay,
                                            fontSize: height / 50,
                                          ),
                                        ),
                                        SizedBox(width: width / 20),
                                      ],
                                    ),
                                  ),
                                );}
                          );
                        }))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:GestureDetector(
        onTap: () {
          Get.find<OrdersController>().cancel(pageId);
        },
        child: Container(
          height: height / 11,
          width: width / 1.1,
          decoration:   BoxDecoration(
            color:     notifier.getbuttoncolor.withOpacity(0.10),
            borderRadius: const BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete, size: height / 30, color:     notifier.getbuttoncolor),
                SizedBox(width: width / 50),
                Text(
                  tr("cancelorder"),
                  style: TextStyle(
                    color:     notifier.getbuttoncolor,
                    fontSize: height / 50,
                    fontFamily: 'Tajawal',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget totalpayment(title, price) {
    return Row(
      children: [
        SizedBox(width: width / 20),
        Text(
          title,
          style: TextStyle(
              fontSize: height / 45, color: notifier.getgreay, fontFamily: 'Tajawal'),
        ),
        const Spacer(),
        Text(
          price,
          style: TextStyle(
              fontSize: height / 45, color: notifier.getgreay, fontFamily: 'Tajawal'),
        ),
        SizedBox(width: width / 20),
      ],
    );
  }

  Widget paymentbox(name, subname) {
    return Container(
      height: height / 11,
      width: width / 1.1,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        border: Border.all(
          color: const Color(0xffE0E0E0),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: width / 25),
          Image.asset("assets/logocard.png", height: height / 23),
          SizedBox(width: width / 23),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 60),
              Text(
                name,
                style: TextStyle(
                  color: notifier.getblack,
                  fontSize: height / 48,
                  fontFamily: 'Tajawal',
                ),
              ),
              SizedBox(height: height / 150),
              Text(
                subname,
                style: TextStyle(
                  color: notifier.getgreay,
                  fontSize: height / 55,
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget adressbox(name, subname) {
    return Container(
      height: height / 11,
      width: width / 1.1,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        border: Border.all(
          color: const Color(0xffE0E0E0),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: width / 23),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 60),
              Text(
                name,
                style: TextStyle(
                  color: notifier.getgreay,
                  fontSize: height / 55,
                  fontFamily: 'Tajawal',
                ),
              ),
              SizedBox(height: height / 150),
              Text(
                subname,
                style: TextStyle(
                  color: notifier.getgreay,
                  fontSize: height / 55,
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
