import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wassilni/routes/route_helper.dart';
import 'package:get/get.dart';

import 'bottomsheet/bottombar.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }


  startTimer(){
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route(){
    Navigator.pushReplacementNamed(context,RouteHelper.getInitial());
    //Get.toNamed(RouteHelper.getMsgs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Lottie.network(
                'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),
        ),
      ),
    );
  }
}
