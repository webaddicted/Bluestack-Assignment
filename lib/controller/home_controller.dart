import 'package:get/get.dart';
import 'package:tournament/data/bean/home_respo.dart';
import 'package:tournament/data/repo/home_repository.dart';
import 'package:tournament/utils/apiutils/api_response.dart';
import 'package:tournament/utils/sp/sp_manager.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  HomeRepository _homeRepo;
  String userName = '';

  HomeController(this._homeRepo);

  final tournamentRespo = (ApiResponse<HomeRespo?>()).obs;

  Future<String> getUserName() async {
    if (userName.isEmpty) userName = await SPManager.getUserName();
    return userName;
  }

  void setUserName(String userName) {
    SPManager.setUserName(userName);
  }

  getTournament(int pageNo) async {
    tournamentRespo.value = ApiResponse.loading();
    var data = await _homeRepo.getTournament(pageNo: pageNo);
    tournamentRespo.value = data;
    // print("LoginRespo : ${callLoginRespo}");
    return data;
  }
}
