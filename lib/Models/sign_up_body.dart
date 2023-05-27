

class SignUpBody {
  int? id;
  String? name;
  String? phone;
  String? password;
  String? img;
  String? imgname;
  String? carimg;
  String? carimgname;
  String? licenseimg;
  String? licenseimgname;
  String? carlicenseimg;
  String? carlicenseimgname;

  SignUpBody(
      {this.id,
        this.name,
        this.phone,
        this.password,
        this.img,
        this.imgname,
        this.carimg,
        this.carimgname,
        this.licenseimg,
        this.licenseimgname,
        this.carlicenseimg,
        this.carlicenseimgname,
      });

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["phone"] = this.phone;
    data["password"] = this.password;
    data["img"] = this.img;
    data["imgname"] = this.imgname;

    data["carimg"] = this.carimg;
    data["carimgname"] = this.carimgname;

    data["licenseimg"] = this.licenseimg;
    data["licenseimgname"] = this.licenseimgname;

    data["carlicenseimg"] = this.carlicenseimg;
    data["carlicenseimgname"] = this.carlicenseimgname;
    return data;
  }
/*
  ClinicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    detailsAr = json['details_ar'];
    detailsEn = json['details_en'];
    city = json['city'];
    address = json['address'];
    cityEn = json['city_en'];
    addressEn = json['address_en'];
    phone = json['phone'];
    email = json['email'];
    img = json['img'];
    amFrom = json['am_from'];
    amTo = json['am_to'];
    pmFrom = json['pm_from'];
    pmTo = json['pm_to'];
    status = json['status'];
    userId = json['user_id'];
    clinicUserId = json['clinic_user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

 */

}
