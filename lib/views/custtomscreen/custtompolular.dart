import 'package:flutter/material.dart';
import 'package:wassilni/utils/colornotifire.dart';
import 'package:provider/provider.dart';

import '/../utils/colors.dart';
import '/../utils/mediaqury.dart';

class CusttomPopular extends StatefulWidget {
  const CusttomPopular({Key? key}) : super(key: key);

  @override
  State<CusttomPopular> createState() => _CusttomPopularState();
}

class _CusttomPopularState extends State<CusttomPopular> {
  List popolatetitlelist = [
    "Labrador Retriever",
    "American Shorthaired",
    "charadrinaee",
    "Speckled Tortoise",
  ];

  List popularpricelist = [
    "150\$",
    "20\$",
    "130\$",
    "280\$",
  ];
  List popularnearadress = [
    "California work suite",
    "California work suite",
    "California work suite",
    "California work suite",
  ];

  List popularimagelist = [
    "assets/pet4.png",
    "assets/pet3.png",
    "assets/pet2.png",
    "assets/pet1.png",
  ];
late ColorNotifier notifier;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Column(
      children: [
        Container(

          height: height / 1.2,
          decoration: BoxDecoration( color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: popolatetitlelist.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(color: notifier.getcardcolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          height: height / 6.12,
                          width: width / 1.1,
                          decoration: const BoxDecoration(
                            // border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: width / 80),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        color: Colors.transparent,
                                        height: height / 7.2,
                                        width: width / 4,
                                        child: Image.asset(
                                          popularimagelist[index],
                                          height: height / 7,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width / 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // SizedBox(height: height/50),
                                      Text(
                                        popolatetitlelist[index],
                                        style: TextStyle(
                                            fontSize: height / 50,
                                            fontFamily: 'Tajawal',
                                            color:notifier.getblack),
                                      ),
                                      SizedBox(height: height / 100),
                                      Row(
                                        children: [
                                          Container(
                                            height: height / 30,
                                            decoration:   BoxDecoration(
                                              color: buttoncolor.withOpacity(0.10),
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: height / 100),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    Text(
                                                      "Male",
                                                      style: TextStyle(
                                                          color: buttoncolor,
                                                          fontSize:
                                                              height / 60,
                                                          fontFamily:
                                                              'Tajawal'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: width / 50),
                                          Container(
                                            height: height / 30,
                                            decoration: const BoxDecoration(
                                              color: Color(0xfffef6e6),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: height / 100),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    Text(
                                                      "1 Year",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.yellow,
                                                          fontSize:
                                                              height / 60,
                                                          fontFamily:
                                                              'Tajawal'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: height / 100),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined,
                                              size: height / 45,
                                              color: greay),
                                          SizedBox(width: width / 100),
                                          Text(
                                            popularnearadress[index],
                                            style: TextStyle(
                                                fontSize: height / 50,
                                                fontFamily: 'Tajawal',
                                                color: Colors.grey),
                                          ),
                                          SizedBox(width: width / 50),
                                          Container(
                                            height: height / 30,
                                            decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withOpacity(0.10),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: height / 100),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    Text(
                                                      "2km",
                                                      style: TextStyle(
                                                          color: black,
                                                          fontSize:
                                                              height / 60,
                                                          fontFamily:
                                                              'Tajawal'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: height / 100),
                                      Text(
                                        popularpricelist[index],
                                        style: TextStyle(
                                          fontSize: height / 45,
                                          fontFamily: 'Tajawal',
                                          color: const Color(0xfff6a838),
                                        ),
                                      ),
                                      SizedBox(height: height / 70),
                                      Row(
                                        children: [
                                          SizedBox(width: width / 3),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
