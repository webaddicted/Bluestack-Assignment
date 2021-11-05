import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tournament/data/bean/language.dart';
import 'package:tournament/utils/common/global_utilities.dart';
import 'package:tournament/utils/common/widget_helper.dart';
import 'package:tournament/utils/constant/api_constant.dart';
import 'package:tournament/utils/constant/color_const.dart';
import 'package:tournament/utils/constant/string_const.dart';
import 'package:tournament/utils/sp/sp_manager.dart';

class Header extends StatelessWidget {
  Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }

  Widget toolbar() {
    var backIcon = IconButton(
      icon: const Icon(
        Icons.sort,
        color: Colors.black,
      ),
      onPressed: () {},
    );
    return getAppBarWithBackBtn(
        title: StringConst.flyingWolf.tr,
        elevation: 0,
        icon: backIcon,
        actions: [
          _getPopupMenu(),
          IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(Icons.logout, color: ColorConst.blackColor))
        ]);
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
          Container(
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
          )
        ],
      )
    ]);
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

  final locales = [
    Language(title: 'English', locale: const Locale('en', 'US'), index: 0),
    Language(title: 'Japanese', locale: const Locale('ja', 'JP'), index: 1),
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
    SPManager.setLocale(locale.languageCode, locale.countryCode);
    Get.updateLocale(locale);
  }
}
