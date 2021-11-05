import 'package:get/get.dart';
import 'package:tournament/controller/home_controller.dart';
import 'package:tournament/data/repo/home_repository.dart';
class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(HomeRepository()), fenix: true);
  }
}
