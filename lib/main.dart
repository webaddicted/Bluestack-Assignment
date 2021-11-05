import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tournament/utils/common/initial_binding.dart';
import 'package:tournament/utils/constant/color_const.dart';
import 'package:tournament/utils/constant/routers_const.dart';
import 'package:tournament/utils/constant/routes_page.dart';
import 'package:tournament/utils/constant/string_const.dart';
import 'package:tournament/utils/sp/sp_manager.dart';
import 'package:tournament/utils/translations/language_translations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    SPManager.getLocale().then((locale) {
      setState(() {
        print("Preference Revoked ${locale.languageCode}");
        Get.updateLocale(locale);
        print("GET LOCALE Revoked ${Get.locale!.languageCode}");
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConst.appName,
      translations: LanguageTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      // theme: ThemeData(
      //   appBarTheme: AppBarTheme(backgroundColor: Colors.amber),
      // ),
      initialBinding: InitialBinding(),
      theme: ThemeData(
        primarySwatch: ColorConst.color,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RoutersConst.initialRoute,
      getPages: routesPage(),
    );
  }
}
