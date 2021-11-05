import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tournament/controller/home_controller.dart';
import 'package:tournament/data/bean/home_respo.dart';
import 'package:tournament/utils/apiutils/api_response.dart';
import 'package:tournament/utils/common/widget_helper.dart';
import 'package:tournament/utils/constant/api_constant.dart';

class TournamentList extends StatelessWidget {
  List<Tournaments>? tournamentsList=[];

  TournamentList({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();
  int pageNo = 1;
  late final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // _scrollController.addListener(() {
    //   // debugPrint(
    //   //     "pixels : ${_scrollController.position
    //   //         .pixels}  \n maxScrollExtent : ${_scrollController.position
    //   //         .maxScrollExtent}");
    //   if (_scrollController.position.pixels > 0 &&
    //       _scrollController.position.pixels ==
    //           _scrollController.position.maxScrollExtent) {
    //     callTournament(pageNo);
    //   }
    // });
    callTournament(pageNo);
    return  Obx(() {
      var respo = _homeController.tournamentRespo.value;
      if (respo.status == ApiStatus.COMPLETED) {
        pageNo++;
        return getItemList(respo.data?.data?.tournaments);
      }else {
        return apiHandler(response: respo);
      }
      // return Container();
    });
  }

  Widget getItemList(List<Tournaments>? tournaments) {
    tournamentsList?.addAll(tournaments!);
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: tournamentsList?.length,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        var list = tournamentsList![index];
        return Padding(
          padding: const EdgeInsets.all(4),
          child: InkWell(
            onTap: () {},
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              // elevation: 3,
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getCacheImage(
                      url: list.coverUrl.toString(), height: 100, placeHolder: 2),
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

  void callTournament(int pageNo) {
    _homeController.getTournament(pageNo);
  }
}
