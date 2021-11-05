import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tournament/utils/constant/routers_const.dart';
import 'package:tournament/utils/sp/sp_manager.dart';

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

logout() {
  SPManager.clearPref();
  Get.offAllNamed(RoutersConst.loginPage);
}

delay({double durationSec = 1, required Function click}) {
  int sec = (durationSec * 1000).toInt();
  Future.delayed(Duration(milliseconds: sec), () {
    click();
  });
}
