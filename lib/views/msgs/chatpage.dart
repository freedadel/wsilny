import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Models/msgs_model.dart';
import '../../controllers/messages_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/show_custom_snackbar.dart';
import 'comps/styles.dart';
import 'comps/widgets.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  final String id;
  const ChatPage({Key? key, required this.id}) : super(key: key);

  void _addMessage(String message,String senderId,String receiverId) {
    MessagesController messagesController = Get.find<MessagesController>();

      MsgModel msgModel = MsgModel(
        comment: message,
        sender_id: int.parse(senderId),
        receiver_id: int.parse(receiverId),
      );
      messagesController.saveMessage(msgModel).then((status) {
        if (kDebugMode) {
          print("Send Message to Controller");
        }
        if (status.isSuccess) {
          //_loadMessages();
        } else {
          showCustomSnackBar(status.message);
        }
      });

  }

  @override
  Widget build(BuildContext context) {
    MessagesController messages = Get.find<MessagesController>();
    return Scaffold(
      backgroundColor: Colors.indigo.shade400,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade400,
        title: Text(messages.messagesList[0].sender),
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Chats',
                  style: Styles.h1(),
                ),
                const Spacer(),
                Text(
                  'Last seen: 04:50',
                  style: Styles.h1().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.white70),
                ),

                const Spacer(),
                const SizedBox(width: 50,)
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: Styles.friendsBox(),

              child: ListView.builder(
                itemCount: messages.messagesList.length,
                reverse: true,
                itemBuilder: (context, i) {
                  return ChatWidgets.messagesCard(i,messages.messagesList[i].comment,messages.messagesList[i].createdAt);
                },
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child:ChatWidgets.messageField(onSubmit: (controller){_addMessage(controller.text.trim(),AppConstants.USER_ID,id);}) ,
          )

        ],
      ),
    );
  }
}
