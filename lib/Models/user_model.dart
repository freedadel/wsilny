class UserModel{
  int? id;
  String name;
  String phone;
  int permission;
  String? img;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.permission,
    required this.img,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        id: json['id'],
        name: json['name'],
        phone: json['email'],
        permission: json['permission'],
        img: json['img'],
    );
  }
}