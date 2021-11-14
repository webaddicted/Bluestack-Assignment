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
import 'package:tournament/utils/apiutils/api_response.dart';
import 'package:tournament/utils/common/widget_helper.dart';
import 'package:tournament/utils/constant/color_const.dart';
import 'package:tournament/utils/constant/routers_const.dart';
import 'package:tournament/utils/constant/string_const.dart';
import 'package:tournament/view/home/header.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();
  late final ScrollController _scrollController = ScrollController();
  List<Tournaments>? tournamentsList = [];
  bool isLoading = false;
  int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onWillPop();
      },
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
        body: createUi(),
      ),
    );
  }

  Widget createUi() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 0 &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        _homeController.getTournament(pageNo);
      }
    });
    _homeController.getTournament(pageNo);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      // physics: const BouncingScrollPhysics(),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Header(),
              Container(
                  margin: const EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  child: getTxtBlackColor(
                      msg: StringConst.recommended_for_you.tr,
                      fontSize: 23,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              getTournamentList()
            ],
          ),
          Obx(() {
            var respo = _homeController.tournamentRespo.value;
            if (respo.status == ApiStatus.LOADING) {
              return Container(
                height: 50,
                width: 50,
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorConst.appColor),
                  ),
                ),
              );
            } else {
              return Container();
            }
          })
        ],
      ),
    );
  }

  Widget getTournamentList() {
    return Obx(() {
      var respo = _homeController.tournamentRespo.value;
      if (respo.status == ApiStatus.COMPLETED ||
          respo.status == ApiStatus.LOADING) {
        if (respo.status == ApiStatus.COMPLETED) pageNo++;
        return getItemList(respo.data?.data?.tournaments);
      } else {
        isLoading = false;
        return apiHandler(response: respo);
      }
      // return Container();
    });
  }

  Widget getItemList(List<Tournaments>? tournaments) {
    if (tournaments != null) {
      tournamentsList?.addAll(tournaments);
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: tournamentsList?.length ?? 0,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        var list = tournamentsList![index];
        return Padding(
          padding: const EdgeInsets.all(4),
          child: InkWell(
            onTap: () {
              Get.toNamed(RoutersConst.detail+"/${list.gameName}", arguments: [list]);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              // elevation: 3,
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getCacheImage(
                      url: list.coverUrl.toString(),
                      height: 100,
                      placeHolder: 2),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(width: 5),
                      const Icon(FontAwesomeIcons.trophy,
                          color: Colors.amberAccent, size: 20),
                      const SizedBox(width: 5),
                      Flexible(
                        child: getTxtBlackColor(
                            msg: list.name.toString(),
                            fontSize: 17,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center),
                      ),
                      const SizedBox(width: 8),
                      const Icon(FontAwesomeIcons.trophy,
                          color: Colors.amberAccent, size: 18),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: getTxtGreyColor(
                        msg: list.gameName.toString(),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
