import 'dart:convert';

import 'package:get/get.dart';
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
      print(response.body.toString());
      getMSGDetails(response.body["receiver_id"].toString());
      update();
      responseModel = ResponseModel(true, response.body.toString());
    }else{
      print(response.body.toString());
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
        //print(_popularProductList);

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

      _messagesDetailsList = [];
      //_messagesDetailsList.addAll(Msg.fromJson(response.body).messages);
      _messagesDetailsList = (jsonDecode(jsonEncode(response.body)) as List)
          .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
          .toList();


      print("Success to get msg details");
      responseModel = ResponseModel(true, response.body.toString());
    }else{
      responseModel = ResponseModel(false, response.statusText!);
      print("Faild to get msg details");
      print(response.body);
    }
    _isLoadedChat = true;
    update();
    return responseModel;
  }



}