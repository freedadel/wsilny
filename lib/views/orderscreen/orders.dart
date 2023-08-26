import 'package:flutter/material.dart';
import 'package:wsilny/utils/colornotifire.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wsilny/utils/mediaqury.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../controllers/orders_controller.dart';


class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int selectedindex = 0;

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

    Get.find<OrdersController>().getOrderList();

    return Scaffold(

      backgroundColor: notifier.getwihite,
      body: Column(
        children: [
          SizedBox(height: height / 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // const Spacer(),
              // Icon(Icons.shopping_basket,
              //     color: buttoncolor, size: height / 30),

            ],
          ),
          SizedBox(height: height / 70),
          Row(
            children: [
              Text(
                tr("currentorders"),
                style:
                TextStyle(fontFamily: 'Tajawal', fontSize: height / 30,color: notifier.getblack),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: SizedBox(
                  width: width / 1.1,
                  child: GetBuilder<OrdersController>(builder: (ordersList){
                    //ordersList.getOrderList();
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: ordersList.ordersList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: (){

                              },
                              child:Padding(
                                padding: const EdgeInsets.all(5.5),
                                child: adressbox("رقم الطلب "+ordersList.ordersList[index].id.toString(), ordersList.ordersList[index].status == 1? tr("processingorder") :tr("confirmedorder") ,
                                    ordersList.ordersList[index].createdAt.toString().substring(0,10), "", "","assets/car.png"),
                              ));
                        }
                    );})),
            ),
          )
        ],
      ),
    );

  }

  Widget adressbox(name, subname, orderdate, price, iteams,icon) {
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
            Image.asset(icon, height: height / 15),
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
                  price,
                  style: TextStyle(
                    color: notifier.getblack,
                    fontSize: height / 40,
                    fontFamily: 'Tajawal',
                  ),
                ),
                Text(
                  iteams,
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
}
