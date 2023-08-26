import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wsilny/utils/app_constants.dart';
import 'package:wsilny/utils/language.dart';
import 'package:wsilny/utils/mediaqury.dart';
import 'package:wsilny/views/bottomsheet/bottombar.dart';
import 'package:wsilny/controllers/auth_controller.dart';
import 'package:wsilny/routes/route_helper.dart';
import 'package:wsilny/utils/colornotifire.dart';
import 'package:provider/provider.dart';
import 'package:wsilny/views/splash.dart';
import 'controllers/ads_controller.dart';
import 'controllers/messages_controller.dart';
import 'controllers/orders_controller.dart';
import 'controllers/user_controller.dart';
import 'helper/dependencies.dart' as dep;
import 'package:get/get.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;

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
  String? _token;
  String? initialMessage;
  bool _resolved = false;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
          (value) => setState(
            () {
          _resolved = true;
          initialMessage = value?.data.toString();
        },
      ),
    );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //print('A new onMessageOpenedApp event was published!');
      Get.find<OrdersController>().getQOrderList();
    });
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'launch_background',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {


      //Get.find<UserController>().getUserInfo();
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
        home: SplashScreen(),
        initialRoute: Get.find<AuthController>().userLoggedIN()?RouteHelper.getInitial():RouteHelper.getLogin(),
        getPages: RouteHelper.routes,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: EasyLocalization.of(context)!.supportedLocales,
        locale: EasyLocalization.of(context)!.locale,
      ),
    );
  }
}


