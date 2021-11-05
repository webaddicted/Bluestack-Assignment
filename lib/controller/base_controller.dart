import 'package:get/get.dart';
import 'package:tournament/data/repo/base_repo.dart';
import 'package:tournament/utils/sp/sp_manager.dart';

class BaseController extends GetxController {
  static BaseController get to => Get.find();
  BaseRepo _baseRepo;

  BaseController(this._baseRepo);
  String userName = '';

  Future<String> getUserName() async {
    if (userName.isEmpty) userName = await SPManager.getUserName();
    return userName;
  }
  void setUserName(String userName){
     SPManager.setUserName(userName);
  }
}
