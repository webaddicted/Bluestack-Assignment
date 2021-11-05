import 'package:get/get.dart';
import 'package:tournament/controller/base_controller.dart';
import 'package:tournament/controller/home_controller.dart';
import 'package:tournament/data/repo/base_repo.dart';
import 'package:tournament/data/repo/home_repository.dart';
class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BaseController(BaseRepo()), fenix: true);
    Get.lazyPut(() => HomeController(HomeRepository()), fenix: true);
  }
}
