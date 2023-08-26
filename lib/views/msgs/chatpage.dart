import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wsilny/utils/colors.dart';
import '../../Models/msgs_model.dart';
import '../../controllers/messages_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/mediaqury.dart';
import '../../utils/show_custom_snackbar.dart';
import '../custtomscreen/button.dart';
import 'comps/styles.dart';
import 'comps/widgets.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  final String id;
  const ChatPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  var _priceController= TextEditingController();
  var _cancelController= TextEditingController();
  String name = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<MessagesController>().getMSGDetails(widget.id.toString());
  }

  void _addMessage(String message,String senderId,String receiverId) {
    MessagesController messagesController = Get.find<MessagesController>();
      MsgModel msgModel = MsgModel(
        comment: message,
        sender_id: int.parse(senderId),
        receiver_id: int.parse(receiverId),
      );
      messagesController.saveMessage(msgModel).then((status) async {
        if (kDebugMode) {
          print("Send Message to Controller");
        }
        if (status.isSuccess) {
          setState(() {});
          await Future.delayed(Duration(seconds: 2));
          setState(() {});
        } else {
          showCustomSnackBar(status.message);
        }
      });

  }

  void _confirmOrder(String price,String senderId,String receiverId) {
    MessagesController messagesController = Get.find<MessagesController>();
    MsgModel msgModel = MsgModel(
      comment: price.toString(),
      sender_id: int.parse(senderId),
      receiver_id: int.parse(receiverId),
    );
    messagesController.confirmOrder(msgModel).then((status) async {
      if (kDebugMode) {
        print("Send Price Message to Controller");
      }
      if (status.isSuccess) {
        AppConstants.CONFIRM_ORDER = true;
        setState(() {});
        await Future.delayed(const Duration(seconds: 2));
        setState(() {});
      } else {
        showCustomSnackBar(status.message);
      }
    });

  }

  void _cancelOrder(String comment,String senderId,String receiverId) {
    MessagesController messagesController = Get.find<MessagesController>();
    MsgModel msgModel = MsgModel(
      comment: comment,
      sender_id: int.parse(senderId),
      receiver_id: int.parse(receiverId),
    );
    messagesController.cancelOrder(msgModel).then((status) async {
      if (kDebugMode) {
        print("Send Cancel Message to Controller");
      }
      if (status.isSuccess) {
        AppConstants.CONFIRM_ORDER = true;
        setState(() {});
        await Future.delayed(const Duration(seconds: 2));
        setState(() {});
      } else {
        showCustomSnackBar(status.message);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    MessagesController messages = Get.find<MessagesController>();
    return Scaffold(
      backgroundColor: buttoncolor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right:height/100,left:height/100,top:height/20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Row(
                 children: [
                   GestureDetector(
                     onTap: () {
                       Navigator.pop(context);
                     },
                     child: Icon(Icons.arrow_back,color: AppColors.buttonBackgroundColor,),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text(name,style:
                     TextStyle(fontFamily: 'Tajawal', fontSize: height / 50,color: Colors.white)),
                   ),
                 ],
               ),
               if(!AppConstants.CONFIRM_ORDER)
               Row(
                 children: [
                   GestureDetector(
                     onTap: (){
                       _displayTextInputDialog(context);
                     },
                     child: Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("تأكيد",style:
                           TextStyle(fontFamily: 'Tajawal', fontSize: height / 50,color: Colors.white)),
                         ),
                         Icon(Icons.check_circle_outline,color: AppColors.buttonBackgroundColor,),
                       ],
                     ),
                   ),


                   SizedBox(width: width / 10),

                   GestureDetector(
                     onTap: (){
                       _cancelTextInputDialog(context);
                     },
                     child: Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("الغاء",style:
                           TextStyle(fontFamily: 'Tajawal', fontSize: height / 50,color: Colors.white)),
                         ),
                         Icon(Icons.cancel_outlined,color: AppColors.buttonBackgroundColor,),
                       ],
                     ),
                   ),

                 ],
               ),

             ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                return Container(
                  decoration: Styles.friendsBox(),

                  child: ListView.builder(
                    itemCount: messages.messagesListDetails.length,
                    reverse: true,
                    itemBuilder: (context, i) {
                      name = messages.messagesListDetails[i].sender;
                      return ChatWidgets.messagesCard(i,messages.messagesListDetails[i].comment,messages.messagesListDetails[i].createdAt,messages.messagesListDetails[i].sender_id.toString());
                    },
                  )
                );
              }
            ),
          ),
          Container(
            color: Colors.white,
            child:ChatWidgets.messageField(onSubmit: (controller){
              _addMessage(controller.text.trim(),AppConstants.USER_ID,widget.id);

            }) ,
          )

        ],
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('كم السعر المتفق عليه؟'),
            content: TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "اكتب السعر"),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  _confirmOrder(_priceController.text.trim(),AppConstants.USER_ID,widget.id);
                },
                child: Custombutton.button(
                  "تأكيد",
                  width / 1.1,
                  Colors.transparent,
                  buttoncolor,
                  white,
                ),
              ),
            ],
          );
        });
  }

  Future<void> _cancelTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('الالغاء'),
            content: TextField(
              controller: _cancelController,
              decoration: InputDecoration(hintText: "اكتب سبب الالغاء"),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  _cancelOrder(_cancelController.text.trim(),AppConstants.USER_ID,widget.id);
                },
                child: Custombutton.button(
                  "الغاء الطلب",
                  width / 1.1,
                  Colors.transparent,
                  buttoncolor,
                  white,
                ),
              ),
            ],
          );
        });
  }
}
