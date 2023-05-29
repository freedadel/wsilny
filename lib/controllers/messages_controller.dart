import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wassilni/Models/msgs_model.dart';
import 'package:wassilni/routes/route_helper.dart';
import '../Models/response_model.dart';
import '../repository/messages_repo.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;


class MessagesController extends GetxController{
  final MessagesRepo messagesRepo;

  MessagesController({required this.messagesRepo});
  List<dynamic> _messagesList = [];
  List<dynamic> get messagesList => _messagesList;

  List<dynamic> _messagesListDetails = [];
  List<dynamic> get messagesListDetails => _messagesListDetails;

  List<types.Message> _messagesDetailsList = [];
  List<types.Message> get messagesDetailsList => _messagesDetailsList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isLoadedChat = true;
  bool get isLoadedChat => _isLoadedChat;



  Future<ResponseModel> saveMessage(MsgModel message) async {
    _isLoaded = false;
    update();
    Response response = await messagesRepo.saveMessage(message);

    late ResponseModel responseModel;
    if(response.statusCode == 200){
      if (kDebugMode) {
        print(response.body.toString());
      }
      getMSGDetails(response.body["receiver_id"].toString());
      responseModel = ResponseModel(true, response.body.toString());
    }else{
      if (kDebugMode) {
        print(response.body.toString());
      }
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoaded = true;
    update();
    return responseModel;
  }

  Future<void> getAllMessagesList()async{
    _isLoaded = false;
    Response response = await messagesRepo.getAllMessagesList();
    if(response.statusCode==200){
      print("success got messages");

      _messagesList = [];
      _messagesList.addAll(Msg.fromJson(response.body).messages);


    }else{
      print("Faild to get messages");
      print(response.body);
    }
    _isLoaded = true;
    update();
  }

  Future<void> getCustomerMessagesList()async{
    _isLoaded = false;
    Response response = await messagesRepo.getCustomerMessagesList();
    if(response.statusCode==200){
      print("success got messages");

      _messagesList = [];
      _messagesList.addAll(Msg.fromJson(response.body).messages);

      //print(_popularProductList);

    }else{
      print("Faild to get messages");
      print(response.body);
    }
    _isLoaded = true;
    update();
  }

  Future<ResponseModel> getMSGDetails(String id)async{
    _isLoadedChat = false;
    update();
    Response response = await messagesRepo.getCustomerDetailsList(id);
    late ResponseModel responseModel;
    if(response.statusCode==200){
      print("success got msg details");

      /*
      _messagesDetailsList = [];
      _messagesDetailsList = (jsonDecode(jsonEncode(response.body)) as List)
          .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
          .toList();


       */
      _messagesListDetails = [];
      _messagesListDetails.addAll(Msg.fromJson(response.body).messages);
      if (kDebugMode) {
        print("Success to get msg details");
      }
      responseModel = ResponseModel(true, response.body.toString());
    }else{
      responseModel = ResponseModel(false, response.statusText!);
      if (kDebugMode) {
        print("Failed to get msg details");
        print(response.body);
      }

    }
    _isLoadedChat = true;
    update();
    return responseModel;
  }
}