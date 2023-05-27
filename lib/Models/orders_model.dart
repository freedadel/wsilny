
class Order {
  int? _totalSize;
  late List<OrderModel> _orders;
  List<OrderModel> get orders => _orders;

  Order({required totalSize, required orders}){
   this._totalSize = totalSize;
   this._orders = orders;
  }

  Order.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    if (json['orders'] != null) {
      _orders = <OrderModel>[];
      json['orders'].forEach((v) {
        _orders.add(OrderModel.fromJson(v));
      });
    }
  }


}
class OrderModel {
  int? id;
  String? from;
  String? to;
  double? lat;
  double? long;
  int? customer_id;
  int? driver_id;
  String? totalAmount;
  String? wsilnyAmount;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? user_id;

  OrderModel(
      {this.id,
        this.from,
        this.to,
        this.lat,
        this.long,
        this.customer_id,
        this.driver_id,
        this.totalAmount,
        this.wsilnyAmount,
        this.status,
        this.createdAt,
        this.updatedAt,
      });

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["from"] = from;
    data["to"] = to;
    data["lat"] = lat;
    data["long"] = long;
    return data;
  }

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json["from"];
    to = json["to"];
    lat = json["lat"];
    long = json["long"];
    customer_id=json["customer_id"];
    driver_id=json["driver_id"];
    totalAmount=json["totalAmount"].toString();
    wsilnyAmount=json["wsilnyAmount"].toString();
    status=json["status"];
    createdAt=json["created_at"];
    updatedAt=json["updated_at"];
  }



}
