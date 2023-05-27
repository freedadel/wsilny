import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wassilni/views/custtomscreen/button.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import '/../utils/mediaqury.dart';

class Onbonding extends StatefulWidget {
  const Onbonding({Key? key}) : super(key: key);

  @override
  _OnbondingState createState() => _OnbondingState();
}

class _OnbondingState extends State<Onbonding> {
  final int _numPages = 3;
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previusstate;
    }
  }



  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  late bool isLoading;

  @override
  void initState() {
    getdarkmodepreviousstate();
    isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 5.0,
      width: isActive ? 25.0 : 15.0,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xfff1a852) : const Color(0xffe0e0e0),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
late ColorNotifier notifier;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: notifier.getwihite,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    color: notifier.getwihite,
                    height: height,
                    child: PageView(
                      physics: const ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: height / 10),
                                    Image.asset("assets/onbondingone.png",
                                        height: height / 2),
                                    SizedBox(height: height / 50),
                                    Text(
                                      tr("petdeservesmorecare"),textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          color: notifier.getblack,
                                          fontSize: height / 32),
                                    ),
                                    SizedBox(height: height / 35),
                                    Text(
                                      tr("weprovideallservices"),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          color: notifier.getgreay,
                                          fontSize: height / 55),
                                    ),
                                    SizedBox(height: height / 40),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: height / 10),
                                    Image.asset("assets/onbondingtwo.png",
                                        height: height / 2),
                                    SizedBox(height: height / 50),
                                    Text(
                                      tr("findyournewfriend"),textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          color: notifier.getblack,
                                          fontSize: height / 32),
                                    ),
                                    SizedBox(height: height / 35),
                                    Text(
                                      tr("donthaveapetfindyour"),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          color: notifier.getgreay,
                                          fontSize: height / 55),
                                    ),
                                    SizedBox(height: height / 40),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: height /10),
                                    Image.asset("assets/onbondingthree.png",
                                        height: height / 2),
                                    SizedBox(height: height / 50),
                                    Text(
                                      tr("allpetneedsarehere"),textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          color: notifier.getblack,
                                          fontSize: height / 32),
                                    ),
                                    SizedBox(height: height / 35),
                                    Text(
                                      tr("shopallpetneedsrightfromyourhand"),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          color: notifier.getgreay,
                                          fontSize: height / 55),
                                    ),
                                    SizedBox(height: height / 40),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _currentPage != _numPages - 1
                ? Column(
                    children: [
                      SizedBox(height: height / 1.25),
                      Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildPageIndicator(),
                        ),
                      ),
                      SizedBox(height: height / 15),
                      Container(
                        color: Colors.transparent,
                        height: height / 11,
                        child: Align(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                _pageController.nextPage(
                                    duration: const Duration(microseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              child: Center(
                                child: Custombutton.button(
                                  tr("next"),
                                  width / 1.1,
                                  notifier.getbuttoncolor,
                                  Colors.transparent,
                                  notifier.getbuttoncolor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(height: height / 1.25),
                      Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildPageIndicator(),
                        ),
                      ),
                      SizedBox(height: height / 15),
                      Container(
                        color: Colors.transparent,
                        height: height / 11,
                        child: Align(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                _pageController.nextPage(
                                    duration: const Duration(microseconds: 300),
                                    curve: Curves.easeIn);
                                Navigator.pushNamed(context, '/Welcome');
                              },
                              child: Center(
                                child: Custombutton.button(
                                  tr("continues"),
                                  width / 1.1,
                                  Colors.transparent,
                                  notifier.getbuttoncolor,
                                  notifier.getwihite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
