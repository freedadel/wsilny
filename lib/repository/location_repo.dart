import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wassilni/Models/address_model.dart';
import 'package:wassilni/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';
import 'package:get/get.dart';
class LocationRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response> getAddressFromGeocode(LatLng latLng) async{

    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
    '?lat=${latLng.latitude}&lng=${latLng.longitude}'
    );
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS)??"";
  }

  Future<Response> addAddress(AddressModel addressModel) async{
    return await apiClient.postData(AppConstants.STORE_ADDRESS_URI, addressModel.toJson());
  }

  Future<Response> getAllAdress() async{
    return await apiClient.getData(AppConstants.GET_ADDRESS_URI);
  }

  Future<bool> saveUserAddress(String userAddress) async{
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, userAddress);
  }
}