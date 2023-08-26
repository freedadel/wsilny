import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/mediaqury.dart';
import 'bottomsheet/bottombar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Center(
      child: AnimatedSplashScreen(
          duration: 4000,
          splash:  Image.asset('assets/dribbble_anim_s_04_v_03.gif',width: width/1.2,height: height/2),
          nextScreen: const Bottomhome(),
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: double.infinity,
          backgroundColor: Colors.white),
    );
  }
}
