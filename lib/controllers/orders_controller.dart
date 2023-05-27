import 'package:get/get.dart';
import 'package:wassilni/routes/route_helper.dart';
import '../Models/orders_model.dart';
import '../Models/response_model.dart';
import '../repository/orders_repo.dart';

class OrdersController extends GetxController{
  final OrdersRepo ordersRepo;

  OrdersController({required this.ordersRepo});
  List<dynamic> _ordersList = [];
  List<dynamic> get ordersList => _ordersList;

  List<dynamic> _qordersList = [];
  List<dynamic> get qordersList => _qordersList;

  List<dynamic> _pastordersList = [];
  List<dynamic> get pastordersList => _pastordersList;

  List<dynamic> _itemsList = [];
  List<dynamic> get itemsList => _itemsList;

  bool _isLoaded = true;
  bool get isLoaded => _isLoaded;

  bool _isLoadedRequests = false;
  bool get isLoadedRequests => _isLoadedRequests;

  Future<ResponseModel> saveOrder(OrderModel order) async {
    _isLoaded = false;
    update();
    Response response = await ordersRepo.saveOrder(order);

    late ResponseModel responseModel;
    if(response.statusCode == 200){
      print(response.body.toString());
      responseModel = ResponseModel(true, response.body.toString());
    }else{
      print(response.body.toString());
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoaded = true;
    update();
    return responseModel;
  }

  Future<void> getOrderList()async{
    _isLoaded = false;
    Response response = await ordersRepo.getOrdersList();
    if(response.statusCode==200){
      print("success got orders");

      _ordersList = [];
      _ordersList.addAll(Order.fromJson(response.body).orders);
        //print(_popularProductList);

    }else{
      print("Faild to get orders");
    }
    _isLoaded = true;
    update();
  }

  Future<void> getQOrderList()async{
    Response response = await ordersRepo.getQOrdersList();
    if(response.statusCode==200){


      _qordersList = [];
      _qordersList.addAll(Order.fromJson(response.body).orders);
      print(response.body);
      print("success got orders requests");

    }else{
      print("Faild to get requests orders");
    }
    _isLoadedRequests = true;
    update();
  }

  Future<void> getOrderListPast()async{
    Response response = await ordersRepo.getOrdersListPast();
    if(response.statusCode==200){
      print("success got past orders");

      _pastordersList = [];
      _pastordersList.addAll(Order.fromJson(response.body).orders);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    }else{
      print("Faild to get past orders");
    }
  }

  Future<void> cancel(int id)async{
    Response response = await ordersRepo.cancel(id);
    if(response.statusCode==200){
      print("success cancel order");
      Get.toNamed(RouteHelper.getOrders());
      _isLoaded = true;
      update();
    }else{
      print("Faild to get items");
    }
  }

}