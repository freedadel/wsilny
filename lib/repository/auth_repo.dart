import 'dart:ffi';

import 'package:wassilni/api/api_client.dart';
import 'package:wassilni/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/sign_up_body.dart';

class AuthRepo extends GetxService{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo ({
    required this.apiClient,
    required this.sharedPreferences
  });


  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  Future<Response> updateUser(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.UPDATE_USER_URI, signUpBody.toJson());
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  bool userLoggedIN() {
    if(sharedPreferences.getString(AppConstants.TOKEN) != null && sharedPreferences.getString(AppConstants.TOKEN).toString() != "None" && sharedPreferences.getString(AppConstants.TOKEN).toString() != ""){
      print("Token = ${sharedPreferences.getString(AppConstants.TOKEN)}");
      AppConstants.PERMISSION = sharedPreferences.getString("permission").toString();
      AppConstants.USERNAME = sharedPreferences.getString("name").toString();
      AppConstants.USER_ID = sharedPreferences.getInt("user_id").toString();
      return true;
    }else{
      print("User Not logged");
      return false;
    }

  }

  Future<Response> login(String phone,String password,String token) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {"phone":phone,"password":password,"token":token});
  }

  Future<Response> updatePassword(String phone,String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI+"-update", {"phone":phone,"password":password});
  }

  Future<Response> verify(String phone) async {
    return await apiClient.postData(AppConstants.LOGIN_URI+"-verify", {"phone":phone});
  }


  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<bool> saveUserName(String name) async {
    return await sharedPreferences.setString("name", name);
  }

  Future<bool> saveUserPermission(int permission) async {
    return await sharedPreferences.setString("permission", permission.toString());
  }

  Future<bool> saveUserId(int id) async {
    return await sharedPreferences.setInt("user_id", id);
  }

  Future<void> saveUserNumberAndPassword(String phone,String password) async {
    try{
      await sharedPreferences.setString(AppConstants.PHONE, phone);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }



  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');

    return true;
  }

}

