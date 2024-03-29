import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:wsilny/routes/route_helper.dart';
import 'package:wsilny/utils/app_constants.dart';
import '../../Models/msgs_model.dart';
import '../../controllers/messages_controller.dart';
import 'package:get/get.dart';

import '../../utils/show_custom_snackbar.dart';




class MessageDetails extends StatefulWidget {
  final int pageId;
  const MessageDetails({Key? key, required this.pageId})  : super(key: key);

  @override
  State<MessageDetails> createState() => _MessageDetailsState();
}

class _MessageDetailsState extends State<MessageDetails> {
  List<types.Message> _messages = [];
  final _user = types.User(
    id: AppConstants.USER_ID.toString(),
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(String message,String senderId,String receiverId) {
    MessagesController messagesController = Get.find<MessagesController>();
    setState(() {
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
          _loadMessages();
        } else {
          showCustomSnackBar(status.message);
        }
      });
    });
  }


  void _handleSendPressed(types.PartialText message) {
    _addMessage(message.text,AppConstants.USER_ID,widget.pageId.toString());
  }

  void _loadMessages() async {
    Get.find<MessagesController>().getMSGDetails(widget.pageId.toString());
    var messages = Get.find<MessagesController>().messagesDetailsList;

    setState(() {
      _messages = messages;
    });
  }

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: _onWillPop,
    child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.toNamed(RouteHelper.getMsgs()),
          ),
          title: const Align(
              alignment: Alignment.centerLeft,
              child: Text("وصلني يلا")),
          backgroundColor: const Color(0xff3413AD),
        ),
        body: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
        )
    ),
  );
}