import 'package:flutter/material.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wassilni/utils/mediaqury.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/../utils/colors.dart';

class ViewAll extends StatefulWidget {
  const ViewAll({Key? key}) : super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  String selected = '';
  int selectedindex = -1;
  List checkList2Items = [
    {
      "id": 0,
      "value": false,
      "title": tr("latestproducts"),
    },
    {
      "id": 1,
      "value": false,
      "title": tr("bestselling"),
    },
    {
      "id": 2,
      "value": false,
      "title": tr("lowprice"),
    },
    {
      "id": 3,
      "value": false,
      "title": tr("highestprice"),
    },
  ];
  final List brand = [
    "King",
    "Pedigree",
    "Baker",
    "Whiskies",
    "Chomp",
    "Pet Toys",
    "Meow",
    "Basche",
    "Domino"
  ];
  late ColorNotifier notifier;
  RangeValues _currentRangeValues = const RangeValues(20, 25);
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
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getwihite,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Row(
          children: [
            GestureDetector(
              onTap: () {
                _shortbottomsheet();
              },
              child: Icon(Icons.filter_list, size: height / 30,color: notifier.getwihite,),
            ),
            SizedBox(width: width / 50),
            GestureDetector(
              onTap: () {
                _shortbottomsheet();
              },
              child: Text(
                tr("sort"),
                style:
                    TextStyle(fontSize: height / 50, fontFamily: 'Tajawal',color: notifier.getwihite),
              ),
            ),
            SizedBox(width: width / 20),
            Container(
              height: height / 20,
              width: width / 250,
              color: notifier.getwihite.withOpacity(0.3),
            ),
            SizedBox(width: width / 20),
            GestureDetector(
                onTap: () {
                  _filterbottomsheet();
                },
                child: Icon(Icons.filter_alt, size: height / 30,color: notifier.getwihite,)),
            SizedBox(width: width / 50),
            GestureDetector(
              onTap: () {
                _filterbottomsheet();
              },
              child: Text(
                tr("filter"),
                style:
                    TextStyle(fontSize: height / 50, fontFamily: 'Tajawal',color: notifier.getwihite),
              ),
            )
          ],
        ),
        // icon: const Icon(Icons.thumb_up),
        backgroundColor: buttoncolor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }

  Future _shortbottomsheet() {
    return showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(height: height / 30),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Text(
                          tr("sort"),
                          style: TextStyle(color: notifier.getblack,
                            fontSize: height / 25,
                            fontFamily: 'Tajawal',
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height / 100),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Text(
                          tr("arrangebasedonthe"),
                          style: TextStyle(
                            color: notifier.getgreay,
                            fontSize: height / 48,
                            fontFamily: 'Tajawal',
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height / 40),
                    Padding(
                      padding: EdgeInsets.only(left: width / 40),
                      child: Column(
                        children: List.generate(
                          checkList2Items.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: width / 1.1,
                              decoration: BoxDecoration(
                                border: Border.all(color: greay),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: CheckboxListTile(
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                    width: 1.0,
                                    color: buttoncolor,
                                  ),
                                ),
                                checkColor: notifier.getwihite,
                                activeColor: buttoncolor,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                contentPadding: EdgeInsets.zero,
                                title: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      SizedBox(width: width / 20),
                                      Text(
                                        checkList2Items[index]["title"],
                                        style: TextStyle(
                                            color: notifier.getblack,
                                            fontSize: height / 60,
                                            fontFamily: 'Tajawal'),
                                      ),
                                    ],
                                  ),
                                ),
                                value: checkList2Items[index]["value"],
                                onChanged: (value) {
                                  setState(
                                    () {
                                      for (var element in checkList2Items) {
                                        element["value"] = false;
                                      }
                                      checkList2Items[index]["value"] = value;
                                      selected =
                                          "${checkList2Items[index]["id"]}, ${checkList2Items[index]["title"]}, ${checkList2Items[index]["value"]}";
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        filterbottomsheetbutton(width / 3, Colors.transparent,
                            notifier.getbuttoncolor, tr("reset"),  notifier.getbuttoncolor),
                        SizedBox(width: width / 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            // Navigator.pushNamed(context, '/Adopt');
                          },
                          child: filterbottomsheetbutton(width / 2,  notifier.getbuttoncolor,
                              Colors.transparent, tr("apply"), notifier.getwihite),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 50),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  Future _filterbottomsheet() {
    return showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(height: height / 30),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Text(
                          tr("filter"),
                          style: TextStyle(color: notifier.getblack,
                            fontSize: height / 25,
                            fontFamily: 'Tajawal',
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height / 100),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Text(
                          tr("filterproductwithmore"),
                          style: TextStyle(
                            color: notifier.getgreay
                            ,
                            fontSize: height / 48,
                            fontFamily: 'Tajawal',
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height / 30),
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        Text(
                          tr("pricerange"),
                          style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: height / 50,
                              color: notifier.getgreay),
                        )
                      ],
                    ),
                    RangeSlider(
                      activeColor: buttoncolor,
                      inactiveColor: const Color(0xffecedfa),

                      values: _currentRangeValues,
                      min: 0,
                      //divisions: 20,
                      max: 100,
                      // labels: RangeLabels(
                      //   _currentRangeValues.start
                      //       .round()
                      //       .toString(),
                      //   _currentRangeValues.end
                      //       .round()
                      //       .toString(),
                      // ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                        });
                      },
                    ),
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        Text(
                          "\$50.00",
                          style: TextStyle(
                            color: notifier.getgreay,
                            fontSize: height / 50,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "\$50.00",
                          style: TextStyle(
                            color: notifier.getgreay,
                            fontSize: height / 50,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        SizedBox(width: width / 20),
                      ],
                    ),
                    SizedBox(height: height / 25),
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        Text(
                          tr("brand"),
                          style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: height / 50,
                              color: notifier.getgreay),
                        )
                      ],
                    ),
                    SizedBox(height: height / 40),
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            height: height / 5,
                            width: width,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: height / 15,
                                      mainAxisExtent: height / 7,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 5),
                              itemCount: brand.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedindex = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xffecedfa),
                                      border: Border.all(
                                        width: 2,
                                        color: selectedindex == index
                                            ? buttoncolor
                                            : Colors.transparent,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        brand[index],
                                        style: TextStyle(
                                            fontFamily: 'Tajawal',
                                            color: notifier.getblack,
                                            fontWeight: FontWeight.normal,
                                            fontSize: height / 55),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 20),
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        filterbottomsheetbutton(width / 3, Colors.transparent,
                          notifier.getbuttoncolor, tr("reset"),  notifier.getbuttoncolor,),
                        SizedBox(width: width / 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            // Navigator.pushNamed(context, '/Adopt');
                          },
                          child: filterbottomsheetbutton(width / 2,  notifier.getbuttoncolor,
                              Colors.transparent, tr("apply"), notifier.getwihite),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 40),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget filterbottomsheetbutton(w, color, bordercolor, txt, fontcolor) {
    return Container(
      height: height / 17,
      width: w,
      decoration: BoxDecoration(
        border: Border.all(color: bordercolor, width: 2),
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: height / 50,
              color: fontcolor),
        ),
      ),
    );
  }

}
