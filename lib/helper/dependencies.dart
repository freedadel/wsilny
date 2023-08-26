import 'package:wsilny/controllers/auth_controller.dart';
import 'package:wsilny/api/api_client.dart';
import 'package:wsilny/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/address_controller.dart';
import '../controllers/ads_controller.dart';
import '../controllers/location_controller.dart';
import '../controllers/messages_controller.dart';
import '../controllers/orders_controller.dart';
import '../controllers/settings_controller.dart';
import '../controllers/user_controller.dart';
import '../repository/address_repo.dart';
import '../repository/ads_repo.dart';
import '../repository/auth_repo.dart';
import '../repository/location_repo.dart';
import '../repository/messages_repo.dart';
import '../repository/orders_repo.dart';
import '../repository/settings_repo.dart';
import '../repository/user_repo.dart';

Future<void> init()async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
    //apiClient
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL,sharedPreferences: Get.find()));
  Get.lazyPut(()=>AuthRepo(apiClient:Get.find(), sharedPreferences:  Get.find()));
  Get.lazyPut(()=>SettingsRepo(apiClient:Get.find(), sharedPreferences:  Get.find()));
  //repo
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => AddressRepo(apiClient: Get.find()));
  Get.lazyPut(() => OrdersRepo(apiClient: Get.find()));
  Get.lazyPut(() => MessagesRepo(apiClient: Get.find()));
  Get.lazyPut(() => AdsRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient:Get.find(),sharedPreferences: Get.find()));

  //controller
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => AddressController(addressRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => AdsController(adsRepo: Get.find()));
  Get.lazyPut(() => OrdersController(ordersRepo: Get.find()));
  Get.lazyPut(() => MessagesController(messagesRepo: Get.find()));
  Get.lazyPut(() => SettingsController(settingsRepo: Get.find()));
}