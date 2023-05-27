

class Addresses {
  int? _totalSize;
  late List<Address> _addresses;
  List<Address> get addresses => _addresses;

  Addresses({required totalSize, required addresses}){
    this._totalSize = totalSize;
    this._addresses = addresses;
  }

  Addresses.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    if (json['addresses'] != null) {
      _addresses = <Address>[];
      json['addresses'].forEach((v) {
        _addresses.add(Address.fromJson(v));
      });
    }
  }

}

class Address {
  int? id;
  String? longitude;
  String? latitude;
  String? address;


  Address(
      {this.id,
        this.longitude,
        this.latitude,
        this.address,
      });

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"]=this.id;
    data["longitude"] = this.longitude;
    data["latitude"] = this.latitude;
    data["address"] = this.address;
    return data;
  }

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['title'];
  }

}


class AddressModel{
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModel({
      id,
      required addressType,
      contactPersonName,
      contactPersonNumber,
      required address,
      required latitude,
      required longitude
  }){
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonNumber;
    _contactPersonNumber = contactPersonNumber;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }

  int get id=>_id??0;
  String get address=>_address;
  String get addressType=> _addressType;
  String? get contactPersonName=>_contactPersonName;
  String? get contactPersonNumber=>_contactPersonNumber;
  String get latitude=>_latitude;
  String get longitude=>_longitude;

AddressModel.fromJson(Map<String,dynamic> json){
  _id=json["id"];
  _addressType=(json["address_type"]??"").toString();
  _contactPersonName=json["contact_person_name"]??"";
  _contactPersonNumber=json["contact_person_number"]??"";
  _address=json["title"]??"";
  _longitude=json["longitude"];
  _latitude=json["latitude"];
}

Map<String,dynamic> toJson(){
  final Map<String,dynamic> data = Map<String,dynamic>();
  data["id"] = this._id;
  data["address_type"] = this._addressType;
  data["contact_person_name"] = this._contactPersonName;
  data["contact_person_number"] = this._contactPersonNumber;
  data["title"] = this._address;
  data["longitude"] = this._longitude;
  data["latitude"] = this._latitude;

  return data;
}


}