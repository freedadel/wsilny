class Ad {
  int? _totalSize;
  late List<AdModel> _ads;
  List<AdModel> get ads => _ads;

  Ad({required totalSize, required ads}){
   this._totalSize = totalSize;
   this._ads = ads;
  }

  Ad.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    if (json['ads'] != null) {
      _ads = <AdModel>[];
      json['ads'].forEach((v) {
        _ads.add(AdModel.fromJson(v));
      });
    }
  }

}

class AdModel {
  int? id;
  String? name;
  String? img;
  int? status;
  int? userId;
  String? createdAt;
  String? updatedAt;

  AdModel(
      {this.id,
        this.name,
        this.img,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt});

  AdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
