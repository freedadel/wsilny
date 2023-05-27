import 'package:flutter/material.dart';
import 'package:wassilni/routes/route_helper.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:wassilni/utils/mediaqury.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../controllers/messages_controller.dart';
import '../../utils/show_custom_snackbar.dart';


class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
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
    Get.find<MessagesController>().getAllMessagesList();
  }

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: notifier.getwihite,
        body: Column(
          children: [
            SizedBox(height: height / 20),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: Icon(Icons.arrow_back,
                      color:  notifier.getbuttoncolor, size: height / 30),
                ),
                SizedBox(width: width / 20),
                Text(
                  "المحادثات",
                  style:
                  TextStyle(fontFamily: 'Tajawal', fontSize: height / 30,color: notifier.getblack),
                ),
              ],
            ),
            SizedBox(height: height / 40),

            Expanded(
              child: Container(
                color: Colors.transparent,
                child: SizedBox(
                    width: width / 1.1,
                    child: GetBuilder<MessagesController>(builder: (messages){
                      //ordersList.getOrderList();
                      return messages.isLoaded?ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: messages.messagesList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: (){
                                  messages.getMSGDetails(messages.messagesList[index].sender_id.toString()).then((status) {
                                    print("Send Message to Controller");
                                    if (status.isSuccess) {
                                      Get.toNamed(RouteHelper.getMsgDetails(messages.messagesList[index].sender_id));
                                    } else {
                                      showCustomSnackBar(status.message);
                                    }
                                  });

                                },
                                child:Padding(
                                  padding: const EdgeInsets.all(5.5),
                                  child: adressbox(messages.messagesList[index].sender, messages.messagesList[index].comment ,
                                      messages.messagesList[index].createdAt.toString().substring(0,10),messages.messagesList[index].status, "","assets/user2.png"),
                                ));
                          }
                      ):Center(child: const CircularProgressIndicator());})),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget adressbox(name, subname, orderdate, msgStatus, iteams,icon) {
    return GestureDetector(
      child: Container(
        height: height / 12,
        width: width / 1.1,
        decoration: BoxDecoration(
          color: msgStatus==1?Colors.transparent:const Color(0xff382e87),
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          ),
          border: Border.all(color: msgStatus==1?const Color(0xffE0E0E0):const Color(0xff382e87),),
        ),
        child: Row(
          children: [
            SizedBox(width: width / 23),
            Icon(Icons.person_outlined,color: Colors.amberAccent,),
            SizedBox(width: width / 23),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height / 60),
                Text(
                  name,
                  style: TextStyle(
                    color: msgStatus==1?notifier.getgreay:notifier.getwihite,
                    fontSize: height / 70,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: height / 150),
                Flexible(
                  child: Text(
                    subname,
                    style: TextStyle(
                      color: msgStatus==1?notifier.getbuttoncolor:notifier.getwihite,
                      fontSize: height / 80,
                      fontFamily: 'Tajawal',
                    ),

                  ),
                ),
                SizedBox(height: height / 150),
                Text(
                  orderdate,
                  style: TextStyle(
                    color: msgStatus==1?notifier.getgreay:notifier.getwihite,
                    fontSize: height / 70,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
