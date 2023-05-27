import 'package:wassilni/api/api_client.dart';
import 'package:wassilni/utils/app_constants.dart';
import 'package:get/get.dart';

class AddressRepo extends GetxService{
  final ApiClient apiClient;

  AddressRepo ({required this.apiClient});

  Future<Response> getAddressList() async {
    return await apiClient.getData(AppConstants.GET_ADDRESS_URI);
  }

}