import 'package:wassilni/api/api_client.dart';
import 'package:wassilni/utils/app_constants.dart';
import 'package:get/get.dart';

class UserRepo extends GetxService{
  final ApiClient apiClient;

  UserRepo ({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }

  Future<Response> sendComment(String text) async {
    return await apiClient.getData(AppConstants.USER_INFO_URI+"/"+text);
  }

  Future<Response> updateLatLong(double lat,double long) async {
    return await apiClient.getData(AppConstants.USER_INFO_URI+"/"+lat.toString()+"/"+long.toString());
  }

}