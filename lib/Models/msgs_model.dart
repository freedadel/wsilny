
class Msg {
  int? _totalSize;
  late List<MsgModel> _messages;
  List<MsgModel> get messages => _messages;

  Msg({required totalSize, required messages}){
   this._totalSize = totalSize;
   this._messages = messages;
  }

  Msg.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    if (json['messages'] != null) {
      _messages = <MsgModel>[];
      json['messages'].forEach((v) {
        _messages.add(MsgModel.fromJson(v));
      });
    }
  }


}
class MsgModel {
  int? id;
  int? sender_id;
  int? receiver_id;
  String? sender;
  String? receiver;
  String? comment;
  String? img;
  String? createdAt;
  String? updatedAt;
  int? status;

  MsgModel(
      {this.id,
        this.sender_id,
        this.receiver_id,
        this.sender,
        this.receiver,
        this.comment,
        this.img,
        this.status,
        this.createdAt,
        this.updatedAt,
      });

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["sender_id"] = sender_id;
    data["receiver_id"] = receiver_id;
    data["sender"] = sender;
    data["receiver"] = receiver;
    data["comment"] = comment;
    data["img"] = img;
    return data;
  }

  MsgModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender_id = json["sender_id"];
    receiver_id = json["receiver_id"];
    sender = json["sender"];
    receiver = json["receiver"];
    comment=json["comment"];
    img=json["img"];
    status=json["status"];
    createdAt=json["created_at"];
    updatedAt=json["updated_at"];
  }



}
