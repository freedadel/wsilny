import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../controllers/messages_controller.dart';
import '../../repository/messages_repo.dart';
import '../../routes/route_helper.dart';


class MessageDetails extends StatefulWidget {
  final int pageId;

  const MessageDetails({Key? key,required this.pageId}) : super(key: key);

  @override
  State<MessageDetails> createState() => _MessageDetails();
}

class _MessageDetails extends State<MessageDetails> {
  List<types.Message> _messages = [];
  late final MessagesRepo messagesRepo;
  final GlobalKey<ChatState> _chatKey = GlobalKey();
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }


  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
          _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
          _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: "1",
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _loadMessages() async {
    //Get.find<MessagesController>().getMSGDetails(widget.pageId.toString());
    //var messages = Get.find<MessagesController>().messagesDetailsList;

      setState(() {
        _messages = _messages;
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
          key: _chatKey,
          messages: Get.find<MessagesController>().messagesDetailsList,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
        )
    ),
  );
}