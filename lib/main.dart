import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wassilni/utils/app_constants.dart';
import 'package:wassilni/utils/language.dart';
import 'package:wassilni/views/bottomsheet/bottombar.dart';
import 'package:wassilni/controllers/auth_controller.dart';
import 'package:wassilni/routes/route_helper.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:provider/provider.dart';
import 'controllers/ads_controller.dart';
import 'controllers/messages_controller.dart';
import 'controllers/orders_controller.dart';
import 'controllers/user_controller.dart';
import 'helper/dependencies.dart' as dep;
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List<Locale> getSupportedLanguages() {
    final List<Locale> localeList = <Locale>[];
    for (final Language lang in AppConstants.psSupportedLanguageList) {
      localeList.add(Locale(lang.languageCode, lang.countryCode));
    }
    print('Loaded Languages');
    return localeList;
  }



  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();

  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      path: 'assets/langs',
      saveLocale: true,
      startLocale: AppConstants.defaultLanguage.toLocale(),
      supportedLocales: getSupportedLanguages(),
      child:const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

//String? token = await FirebaseMessaging.instance.getToken();
  @override
  Widget build(BuildContext context) {


    if(Get.find<AuthController>().userLoggedIN())
    {
      Get.find<UserController>().getUserInfo();
    }

    Get.find<AdsController>().getAdsList();
    Get.find<MessagesController>().getAllMessagesList();
    Get.find<OrdersController>().getOrderList();
    Get.find<OrdersController>().getQOrderList();

    print(context.locale.toString());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ColorNotifier()),

      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Tajawal",
        ),
        home: Bottomhome(),
        initialRoute: Get.find<AuthController>().userLoggedIN()?RouteHelper.getInitial():RouteHelper.getLogin(),
        getPages: RouteHelper.routes,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: EasyLocalization.of(context)!.supportedLocales,
        locale: EasyLocalization.of(context)!.locale,
      ),
    );
  }
}
