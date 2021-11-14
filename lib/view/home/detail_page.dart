import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tournament/controller/home_controller.dart';
import 'package:tournament/data/bean/home_respo.dart';
import 'package:tournament/utils/common/widget_helper.dart';
import 'package:tournament/utils/constant/color_const.dart';

class DetailPage extends GetView<HomeController> {
  DetailPage({Key? key}) : super(key: key);
  late Tournaments tournamentItem;
  List<dynamic> productList = [];
  List<String> size = [
    "S",
    "M",
    "L",
    "XL",
  ];

  List<Color> colors = [
    Colors.black,
    Colors.purple,
    Colors.orange.shade200,
    Colors.blueGrey,
    const Color(0xFFFFC1D9),
  ];

  final int selectedColor = 0;
  final int selectedSize = 1;
  var selectedRange = RangeValues(150.00, 1500.00);

  @override
  Widget build(BuildContext context) {
    tournamentItem = Get.arguments[0];
    return Scaffold(
        backgroundColor: ColorConst.whiteColor,
        floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            child: const Icon(FontAwesomeIcons.filter),
            backgroundColor: ColorConst.appColor,
            onPressed: () {
              showBottomSheet();
            }),
        body: createUi());
  }

  Widget createUi() {
    var homeIcon = IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: ColorConst.blackColor,
        ),
        onPressed: () => Get.back());
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            backgroundColor: ColorConst.whiteColor,
            expandedHeight: 330.0,
            leading: homeIcon,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: InkWell(
                  onTap: () {
                    // model.fetchPersonMovie(personId);
                  },
                  child: getTxtBlackColor(
                      msg: tournamentItem.name ?? "",
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              background: Hero(
                  tag: tournamentItem.name ?? "",
                  child: getCacheImage(
                    url: tournamentItem.coverUrl.toString(),
                  )),
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(45),
                child: Transform.translate(
                  offset: const Offset(0, 1),
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                        child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
                  ),
                ))),
        SliverList(
          delegate: SliverChildListDelegate([getContent()]),
        )
      ],
    );
  }

  Widget getContent() {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTxtBlackColor(
                          msg: tournamentItem.name ?? "",
                          fontSize: 22,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold),
                      const SizedBox(height: 5),
                      getTxtColor(
                          msg: tournamentItem.gameName ?? "",
                          txtColor: Colors.orange.shade400,
                          fontSize: 14),
                    ],
                  ),
                ),
                getTxtBlackColor(
                    msg: "\$ " + tournamentItem.teamSize.toString()),
              ],
            ),
            const SizedBox(height: 20),
            getTxtBlackColor(
                msg: "${tournamentItem.rules}\n${tournamentItem.rules} "),
            const SizedBox(height: 30),
            getTxtGreyColor(
                msg: "Color", fontSize: 18, fontWeight: FontWeight.bold),
            const SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   _selectedColor = index;
                      // });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: selectedColor == index
                              ? colors[index]
                              : colors[index].withOpacity(0.5),
                          shape: BoxShape.circle),
                      width: 40,
                      height: 40,
                      child: Center(
                        child: selectedColor == index
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : Container(),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Size',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 18),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: size.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   _selectedSize = index;
                      // });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: selectedSize == index
                              ? Colors.yellow[800]
                              : Colors.grey.shade200,
                          shape: BoxShape.circle),
                      width: 40,
                      height: 40,
                      child: Center(
                        child: Text(
                          size[index],
                          style: TextStyle(
                              color: selectedSize == index
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
                onPressed: () => Get.back(),
                height: 45,
                elevation: 0,
                splashColor: Colors.yellow[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.yellow[800],
                child: Center(
                    child: getTxtWhiteColor(msg: "Add to Cart", fontSize: 18)))
          ],
        ));
  }

  showBottomSheet() {
    Get.bottomSheet(StatefulBuilder(builder: (context, setState) {
      return Container(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTxtBlackColor(
                      msg: 'Filter', fontSize: 20, fontWeight: FontWeight.bold),
                  MaterialButton(
                    onPressed: () => Get.back(),
                    minWidth: 40,
                    height: 40,
                    color: Colors.grey.shade300,
                    elevation: 0,
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              getTxtBlackColor(
                  msg: "Color", fontWeight: FontWeight.bold, fontSize: 16),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   _selectedColor = index;
                        // });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: selectedColor == index
                                ? colors[index]
                                : colors[index].withOpacity(0.5),
                            shape: BoxShape.circle),
                        width: 40,
                        height: 40,
                        child: Center(
                          child: selectedColor == index
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : Container(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              getTxtBlackColor(
                  msg: 'Size', fontSize: 16, fontWeight: FontWeight.bold),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: size.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   _selectedSize = index;
                        // });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: selectedSize == index
                                ? Colors.yellow[800]
                                : Colors.grey.shade200,
                            shape: BoxShape.circle),
                        width: 40,
                        height: 40,
                        child: Center(
                          child: getTxtColor(
                              msg: size[index],
                              txtColor: selectedSize == index
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Slider Price Renge filter
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTxtBlackColor(
                      msg: 'Price Range',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      getTxtGreyColor(
                          msg: '\$ ${selectedRange.start.toStringAsFixed(2)}',
                          fontSize: 12),
                      getTxtGreyColor(msg: " - "),
                      getTxtGreyColor(
                          msg: '\$ ${selectedRange.end.toStringAsFixed(2)}',
                          fontSize: 12),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              RangeSlider(
                  values: selectedRange,
                  min: 0.00,
                  max: 2000.00,
                  divisions: 100,
                  inactiveColor: Colors.grey.shade300,
                  activeColor: Colors.yellow[800],
                  labels: RangeLabels(
                    '\$ ${selectedRange.start.toStringAsFixed(2)}',
                    '\$ ${selectedRange.end.toStringAsFixed(2)}',
                  ),
                  onChanged: (RangeValues values) {
                    setState(() => selectedRange = values);
                  }),
              const SizedBox(height: 20),
              button('Filter', () {})
            ],
          ),
      );
    }),
        elevation: 20.0,
        enableDrag: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        )));
  }

  button(String text, Function onPressed) {
    return MaterialButton(
      onPressed: () => onPressed(),
      height: 50,
      elevation: 0,
      splashColor: Colors.yellow[700],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.yellow[800],
      child: Center(
        child: Center(
          child: getTxtWhiteColor(msg: text, fontSize: 18),
        ),
      ),
    );
  }
}
