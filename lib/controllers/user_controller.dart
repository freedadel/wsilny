import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:wsilny/controllers/auth_controller.dart';
import '../Models/response_model.dart';
import '../Models/user_model.dart';
import '../repository/user_repo.dart';
import '../routes/route_helper.dart';
import '../utils/app_constants.dart';
import '../utils/show_custom_snackbar.dart';

class UserController extends GetxController{
  final UserRepo userRepo;

  UserController({required this.userRepo});
  UserModel? _userInfo;
  UserModel get userInfo => _userInfo!;
  bool _isLoaded = true;
  bool get isLoaded => _isLoaded;

  bool _isUserLoaded = false;
  bool get isUserLoaded => _isUserLoaded;

  Future<ResponseModel> getUserInfo() async{
    _isUserLoaded = false;
    late ResponseModel responseModel;
    Response response = await userRepo.getUserInfo();

    if(response.statusCode==200){
      print(response.body['status']);
        if(response.body['status'] == 200){
          _userInfo = UserModel.fromJson(response.body['user']);
          responseModel = ResponseModel(true, "successfully");
        }else{
          showCustomSnackBar(tr("notverified"));
          Get.toNamed(RouteHelper.getLogin());
        }


    }else{
      responseModel = ResponseModel(false, response.statusText!);
      print("Faild to get user info");
    }
    _isUserLoaded = true;
    update();
    return responseModel;
  }

  Future<ResponseModel> sendComment(String text) async{
    _isLoaded = false;
    update();
    late ResponseModel responseModel;
    Response response = await userRepo.getUserInfo();

    if(response.statusCode==200){


    }else{
      responseModel = ResponseModel(false, response.statusText!);
      print("Faild to get user info");
    }
    _isLoaded = true;
    update();
    return responseModel;
  }

  Future<ResponseModel> updateLatLong(double lat,double long) async{
    _isLoaded = false;
    update();
    late ResponseModel responseModel;
    Response response = await userRepo.updateLatLong(lat,long);

    if(response.statusCode==200){

      responseModel = ResponseModel(false, response.statusText!);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
      print(response.body);
    }
    _isLoaded = true;
    update();
    return responseModel;
  }


}