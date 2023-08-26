import 'package:wsilny/Models/orders_model.dart';
import 'package:wsilny/api/api_client.dart';
import 'package:wsilny/utils/app_constants.dart';
import 'package:get/get.dart';

import '../Models/msgs_model.dart';

class MessagesRepo extends GetxService{
  final ApiClient apiClient;

  MessagesRepo ({required this.apiClient});

  Future<Response> getAllMessagesList() async {
    return await apiClient.getData(AppConstants.ALL_MESSAGES_URI);
  }

  Future<Response> getCustomerMessagesList() async {
    return await apiClient.getData(AppConstants.CUSTOMER_MESSAGES_URI);
  }

  Future<Response> getCustomerDetailsList(String id) async {
    return await apiClient.getData(AppConstants.ALL_MESSAGES_URI+"/"+id);
    //return await apiClient.getData(AppConstants.DETAILS_MESSAGES_URI);
  }

  Future<Response> saveMessage(MsgModel message) async {
    return await apiClient.postData(AppConstants.STORE_MESSAGE_URI, message.toJson());
  }

  Future<Response> confirmOrder(MsgModel message) async {
    return await apiClient.postData(AppConstants.CONFIRM_ORDER_URI, message.toJson());
  }

  Future<Response> cancelOrder(MsgModel message) async {
    return await apiClient.postData(AppConstants.CANCEL_ORDER_URI, message.toJson());
  }

}