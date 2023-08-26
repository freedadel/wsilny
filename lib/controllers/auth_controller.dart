import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wsilny/Models/response_model.dart';
import 'package:wsilny/Models/sign_up_body.dart';
import 'package:get/get.dart';
import 'package:wsilny/routes/route_helper.dart';
import '../Models/address_model.dart';
import '../repository/auth_repo.dart';
import '../utils/show_custom_snackbar.dart';


class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String phone = "";

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body["token"]);
      authRepo.saveUserPermission(response.body["permission"]);
      authRepo.saveUserName(response.body["name"]);
      authRepo.saveUserId(response.body["id"]);
      responseModel = ResponseModel(true, response.body["token"]);
      print(response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> updateUser(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.updateUser(signUpBody);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
      print(response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone,String password) async {
    _isLoading = true;
    update();
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    Response response = await authRepo.login(phone,password,token!);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body["token"]);
      authRepo.saveUserPermission(response.body["permission"]);
      authRepo.saveUserName(response.body["name"]);
      authRepo.saveUserId(response.body["id"]);
      responseModel = ResponseModel(true, response.body["token"]);
      print("Token = "+response.body["token"]);
      Get.toNamed(RouteHelper.initial);
    }else{
      responseModel = ResponseModel(false, response.body.toString());
    }
    _isLoading = false;
    update();

    return responseModel;
  }

  Future<ResponseModel> updatePassword(String phone,String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.updatePassword(phone,password);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
      print("Token = "+response.body["token"]);
      Get.toNamed(RouteHelper.initial);
    }else{
      print(response.body);
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();

    return responseModel;
  }

  Future<ResponseModel> verify(String phone) async {
    _isLoading = true;
    update();
    Response response = await authRepo.verify(phone);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      phone = phone;
      Get.toNamed(RouteHelper.getUpdatePassword());
    }else{
      showCustomSnackBar(tr("notverified"));
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();

    return responseModel;
  }

  void saveUserNumberAndPassword(String phone,String password) {
    authRepo.saveUserNumberAndPassword(phone, password);
  }

  bool userLoggedIN() {

    return authRepo.userLoggedIN();
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }

  Future<ResponseModel> clearData(String user_id) async {
    _isLoading = true;
    update();
    Response response = await authRepo.clearData(user_id);
    late ResponseModel responseModel;
    if(response.statusCode != 200)
    {
      showCustomSnackBar(tr("notdeleted"));
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();

    return responseModel;
  }


}
