import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/colors.dart';
import 'utils/mediaqury.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previusstate;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdarkmodepreviousstate();
  }
  final _loremIpsum =
      "Uh Oh. Did your pet eat a little too much over the holidays? Maybe all of that sumptuous feasting left him a bit on the chubby side! Though pets are very adorable when pudgy;";
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
late ColorNotifier notifier;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: notifier.getwihite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 14),
            Row(
              children: [
                SizedBox(width: width / 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,
                      size: height / 30, color: buttoncolor),
                ),
                SizedBox(width: width / 3.1),
                Text(
                  "FAQ",
                  style: TextStyle(
                    color: notifier.getblack,
                    fontSize: height / 40,
                    fontFamily: 'Tajawal',
                  ),
                )
              ],
            ),
            // SizedBox(height: height / ),
            // Center(
            //   child: textField(
            //       "Search topics or questions",
            //       Colors.redAccent,
            //       Icons.search_rounded,
            //       Colors.grey,
            //       Colors.black,
            //       Colors.black,
            //       Colors.grey,
            //       45,
            //       300),
            // ),
            // SizedBox(height: height / 17),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     GestureDetector(
            //         onTap: () {
            //
            //         },
            //         child: faqtype(
            //             "assets/images/Getting.png", "Getting\nStarted")),
            //     GestureDetector(
            //         onTap: () {
            //
            //         },
            //         child: faqtype(
            //             "assets/images/Prices.png", "How to\nInvest")),
            //     GestureDetector(
            //         onTap: () {
            //
            //         },
            //         child: faqtype(
            //             "assets/images/Card-payment.png", "Payment\nMethod")),
            //   ],
            // ),
            SizedBox(height: height / 40),
            Row(
              children: [
                SizedBox(width: width / 15),
                Text(
                  "Top Questions",
                  style: TextStyle(
                      color: notifier.getblack,
                      fontSize: height / 50,
                      fontFamily: 'Tajawal'),
                ),
              ],
            ),
            SizedBox(height: height / 50),
            Accordion(
              disableScrolling: true,
              flipRightIconIfOpen: true,
              contentVerticalPadding: 0,
              scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
              contentBorderColor: Colors.transparent,
              maxOpenSections: 1,
              headerBackgroundColorOpened: Colors.black54,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              children: [
                AccordionSection(
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  headerBackgroundColor: Colors.white,
                  header: Text(
                    'Is my pet too fat?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: height / 55,
                        fontWeight: FontWeight.bold),
                  ),
                  content: Text(_loremIpsum, style: _contentStyle),
                  contentHorizontalPadding: 20,
                  contentBorderWidth: 1,
                ),
                AccordionSection(
                  flipRightIconIfOpen: true,
                  headerBackgroundColor: Colors.white,
                  header: Text(
                    'Why does my dog eat grass?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: height / 55,
                        fontWeight: FontWeight.bold),
                  ),
                  content: Text(_loremIpsum, style: _contentStyle),
                  contentHorizontalPadding: 20,
                  contentBorderWidth: 1,
                ),
                AccordionSection(
                  flipRightIconIfOpen: true,
                  headerBackgroundColor: Colors.white,
                  header: Text(
                    'Should I brush my pet’s teeth?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: height / 55,
                        fontWeight: FontWeight.bold),
                  ),
                  content: Text(_loremIpsum, style: _contentStyle),
                  contentHorizontalPadding: 20,
                  contentBorderWidth: 1,
                ),
              ],
            ),
            // type("How to buy stocks?", Icons.add),
          ],
        ),
      ),
    );
  }
}
