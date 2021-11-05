import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tournament/controller/home_controller.dart';
import 'package:tournament/data/bean/language.dart';
import 'package:tournament/utils/common/widget_helper.dart';
import 'package:tournament/utils/constant/api_constant.dart';
import 'package:tournament/utils/constant/color_const.dart';
import 'package:tournament/utils/constant/string_const.dart';
import 'package:tournament/utils/translations/locale_constant.dart';
import 'package:tournament/view/widget/tournaments_list.dart';

class HomePage extends GetView<HomeController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();
  int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConst.whiteColor,
      body: createUi(),
    );
  }

  late final ScrollController _scrollController = ScrollController();

  Widget createUi() {
    _scrollController.addListener(() {
      // debugPrint(
      //     "pixels : ${_scrollController.position
      //         .pixels}  \n maxScrollExtent : ${_scrollController.position
      //         .maxScrollExtent}");
      if (_scrollController.position.pixels > 0 &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        _homeController.getTournament(pageNo);
        pageNo++;
      }
    });
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      // physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          toolbar(),
          const SizedBox(height: 10),
          userInfo(),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            getTournamentItem(
                "34", StringConst.tournaments_played.tr, Colors.pinkAccent, 0),
            getTournamentItem(
                "09", StringConst.tournaments_won.tr, Colors.purpleAccent, 1),
            getTournamentItem(
                "26%", StringConst.winning_percentage.tr, Colors.redAccent, 2),
          ]),
          const SizedBox(height: 15),
          Container(
              margin: const EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              child: getTxtBlackColor(
                  msg: StringConst.recommended_for_you.tr,
                  fontSize: 23,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          TournamentList()
        ],
      ),
    );
  }

  Widget toolbar() {
    var backIcon = IconButton(
      icon: const Icon(
        Icons.sort,
        color: Colors.black,
      ),
      onPressed: () {
        _homeController.getTournament(1);
      },
    );
    return getAppBarWithBackBtn(
        title: StringConst.flyingWolf.tr,
        elevation: 0,
        icon: backIcon,
        actions: [_getPopupMenu()]);
  }

  final locales = [
    Language(title: 'English', locale: Locale('en', 'US'), index: 0),
    Language(title: 'Japanese', locale: Locale('ja', 'JP'), index: 1),
    Language(title: 'اردو', locale: Locale('ur', 'PK'), index: 2),
    Language(title: 'سنڌي', locale: Locale('sd', 'PK'), index: 3),
  ];

  Widget _getPopupMenu() {
    return PopupMenuButton(
        onSelected: (int selected) {
          updateLocale(locale: locales[selected].locale!);
        },
        icon: const Icon(
          Icons.language,
          color: Colors.black,
        ),
        itemBuilder: (_) => locales.map((game) {
              return PopupMenuItem<int>(
                  child: getTxtBlackColor(
                      msg: game.title.toString(),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  value: game.index);
            }).toList());
  }

  updateLocale({required Locale locale}) {
    Get.back();
    setLocale(locale.languageCode, locale.countryCode);
    Get.updateLocale(locale);
  }

  Widget userInfo() {
    return Row(children: [
      const SizedBox(width: 10),
      getCacheImage(
          url: ApiConstant.demoImg, height: 100, width: 100, isCircle: true),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getTxtBlackColor(
              msg: StringConst.deepakSharma.tr,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          const SizedBox(height: 15),
          buildTag(),
        ],
      )
    ]);
  }

  Container buildTag() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 25.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: ColorConst.lightBlue),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(
        children: [
          getTxtColor(
              msg: "2250",
              txtColor: ColorConst.lightBlue,
              fontSize: 22,
              fontWeight: FontWeight.w700),
          const SizedBox(width: 10),
          getTxtGreyColor(msg: StringConst.eloRating.tr, fontSize: 14),
        ],
      ),
    );
  }

  Widget getTournamentItem(String score, String description,
      MaterialAccentColor purpleAccent, int itemPos) {
    var borderRadius;
    if (itemPos == 0) {
      borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(15), bottomLeft: Radius.circular(15));
    } else if (itemPos == 2) {
      borderRadius = const BorderRadius.only(
          topRight: Radius.circular(15), bottomRight: Radius.circular(15));
    }
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
      decoration:
          BoxDecoration(borderRadius: borderRadius, color: purpleAccent),
      child: Column(
        children: [
          getTxtWhiteColor(
              msg: score, fontWeight: FontWeight.bold, fontSize: 17),
          const SizedBox(height: 3),
          getTxtWhiteColor(
              msg: description, fontSize: 16, textAlign: TextAlign.center),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
