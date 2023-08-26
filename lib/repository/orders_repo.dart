import 'package:wsilny/Models/orders_model.dart';
import 'package:wsilny/api/api_client.dart';
import 'package:wsilny/utils/app_constants.dart';
import 'package:get/get.dart';

class OrdersRepo extends GetxService{
  final ApiClient apiClient;

  OrdersRepo ({required this.apiClient});

  Future<Response> getOrdersList() async {
    return await apiClient.getData(AppConstants.ORDERS_URI);
  }

  Future<Response> getQOrdersList() async {
    return await apiClient.getData(AppConstants.ORDERS_URI+"-requests");
  }

  Future<Response> getOrdersListPast() async {
    return await apiClient.getData(AppConstants.ORDERS_URI+"-past");
  }

  Future<Response> getItemsList(int id) async {
    return await apiClient.getData(AppConstants.ORDERS_URI+"/"+id.toString());
  }

  Future<Response> cancel(int id) async {
    return await apiClient.getData("${AppConstants.ORDERS_URI}-cancel/$id");
  }

  Future<Response> saveOrder(OrderModel order) async {
    return await apiClient.postData(AppConstants.STORE_ORDER_URI, order.toJson());
  }

}