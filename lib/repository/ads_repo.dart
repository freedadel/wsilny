import 'package:wassilni/api/api_client.dart';
import 'package:wassilni/utils/app_constants.dart';
import 'package:get/get.dart';

class AdsRepo extends GetxService{
  final ApiClient apiClient;

  AdsRepo ({required this.apiClient});

  Future<Response> getAdsList() async {
    return await apiClient.getData(AppConstants.ADS_URI);
  }

}