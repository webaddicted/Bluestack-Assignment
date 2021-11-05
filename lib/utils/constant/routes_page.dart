import 'package:get/route_manager.dart';
import 'package:tournament/utils/constant/routers_const.dart';
import 'package:tournament/view/home/home_page.dart';
import 'package:tournament/view/login/login_page.dart';
import 'package:tournament/view/splash/splash_page.dart';

List<GetPage> routesPage() => [
      GetPage(name: RoutersConst.initialRoute, page: () => const SplashPage()),
      GetPage(name: RoutersConst.loginPage, page: () => const LoginPage()),
      GetPage(name: RoutersConst.home, page: () => HomePage()),
    ];
