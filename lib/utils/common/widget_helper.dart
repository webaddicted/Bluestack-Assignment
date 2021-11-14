import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tournament/utils/apiutils/api_response.dart';
import 'package:tournament/utils/common/validation_helper.dart';
import 'package:tournament/utils/constant/assets_const.dart';
import 'package:tournament/utils/constant/color_const.dart';
import 'package:tournament/utils/constant/routers_const.dart';
import 'package:tournament/utils/constant/string_const.dart';
import 'package:tournament/utils/sp/sp_manager.dart';

//  {START TEXT VIEW}
Text getTxt(
    {required String msg,
    FontWeight fontWeight = FontWeight.normal,
    int? maxLines,
    TextAlign textAlign = TextAlign.start}) {
  return Text(msg,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(fontWeight: fontWeight));
}

Text getTxtAppColor(
    {required String msg,
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.normal,
    int? maxLines,
    TextOverflow? overflow,
    Color? bgColor,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    msg,
    maxLines: maxLines,
    textAlign: textAlign,
    overflow: overflow,
    style: _getFontStyle(
        txtColor: ColorConst.appColor,
        fontSize: fontSize,
        bgColor: bgColor,
        fontWeight: fontWeight),
  );
}

Text getTxtWhiteColor(
    {required String msg,
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.normal,
    int? maxLines,
    Color? bgColor,
    TextOverflow? overflow,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    msg,
    maxLines: maxLines,
    textAlign: textAlign,
    overflow: overflow,
    style: _getFontStyle(
        txtColor: ColorConst.whiteColor,
        fontSize: fontSize,
        bgColor: bgColor,
        fontWeight: fontWeight),
  );
}

Text getTxtBlackColor(
    {required String msg,
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.normal,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign textAlign = TextAlign.start,
    Color? bgColor}) {
  return Text(
    msg,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow, //TextOverflow.ellipsis,
    style: _getFontStyle(
        txtColor: ColorConst.blackColor,
        fontSize: fontSize,
        bgColor: bgColor,
        fontWeight: fontWeight),
  );
}

Text getTxtGreyColor(
    {required String msg,
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.normal,
    TextOverflow? overflow,
    int? maxLines,
    Color? bgColor,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    msg,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: _getFontStyle(
        txtColor: ColorConst.greyColor,
        fontSize: fontSize,
        bgColor: bgColor,
        fontWeight: fontWeight),
  );
}

Text getTxtColor(
    {required String msg,
    required Color txtColor,
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.normal,
    int? maxLines,
    TextOverflow? overflow,
    Color? bgColor,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    msg,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: _getFontStyle(
        txtColor: txtColor,
        fontSize: fontSize,
        bgColor: bgColor,
        fontWeight: fontWeight),
  );
}

TextStyle _getFontStyle(
    {required Color txtColor,
    double fontSize = 15,
    Color? bgColor,
    FontWeight fontWeight = FontWeight.normal,
    String fontFamily = AssetsConst.zillasLabFont,
    TextDecoration txtDecoration = TextDecoration.none}) {
  return TextStyle(
      color: txtColor,
      fontSize: fontSize,
      backgroundColor: bgColor,
      decoration: txtDecoration,
      fontFamily: fontFamily,
      fontWeight: fontWeight);
}

//  {END TEXT VIEW}

Widget edtPwdField(
    {required TextEditingController control,
    bool pwdVisible = false,
    bool isRect = true,
    int txtLength = 32,
    IconData icons = Icons.lock_outline,
    Function? pwdVisibleClick}) {
  return TextFormField(
    controller: control,
    maxLength: txtLength,
    decoration: InputDecoration(
      counterText: '',
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      border: OutlineInputBorder(
          borderRadius:
              isRect ? BorderRadius.circular(0) : BorderRadius.circular(30)),
      hintText: "Password",
      prefixIcon: Icon(icons),
      suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            pwdVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            pwdVisibleClick!();
          }),
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w300,
        color: Colors.grey,
      ),
    ),
    obscureText: !pwdVisible,
    textInputAction: TextInputAction.done,
    validator: ValidationHelper.validatePassword,
  );
}

Widget edtRectField(
    {TextEditingController? control,
    String hint = '',
    validate,
    IconData? icons,
    bool isRect = true,
    int txtLength = 32,
    keyboardType,
    bool isReadOnly = false,
    int maxLine = 1,
    double contentVerticalPadding = 5,
    double contentHoriPadding = 5,
    textCapitalization = TextCapitalization.words}) {
  return TextFormField(
      textCapitalization: textCapitalization,
      //TextCapitalization.words,
      controller: control,
      textInputAction: TextInputAction.next,
      maxLength: txtLength,
      validator: validate,
      keyboardType: keyboardType,
      maxLines: maxLine,
      // TextInputType.number,
      readOnly: isReadOnly,
      decoration: InputDecoration(
        counterText: '',
        contentPadding: EdgeInsets.symmetric(
            horizontal: contentHoriPadding, vertical: contentVerticalPadding),
        border: OutlineInputBorder(
            borderRadius:
                isRect ? BorderRadius.circular(0) : BorderRadius.circular(30)),
        hintText: hint,
        prefixIcon: Icon(icons),
        labelText: hint,
        hintStyle:
            const TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
      ));
}

AppBar getAppBarWithBackBtn(
    {String title = '',
    Color bgColor = ColorConst.whiteColor,
    double fontSize = 17,
    double elevation = 2,
    String titleTag = '',
    Widget? icon,
    List<Widget>? actions}) {
  icon ??= IconButton(
    icon: const Icon(
      Icons.arrow_back_ios,
      color: Colors.black,
    ),
    onPressed: () => Get.back(),
  );
  return AppBar(
    elevation: elevation,
    backgroundColor: bgColor,
    leading: icon,
    actions: actions,
    centerTitle: true,
    title: Hero(
        tag: titleTag,
        child: getTxtColor(
            msg: title,
            txtColor: ColorConst.blackColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold)),
  );
}

onWillPop() async {
  Widget widget = AlertDialog(
    content: getTxtColor(
        msg: StringConst.areYouSureExit,
        fontSize: 17,
        txtColor: ColorConst.blackColor),
    title: getTxtBlackColor(
        msg: StringConst.warning, fontSize: 18, fontWeight: FontWeight.bold),
    actions: <Widget>[
      MaterialButton(
          child: getTxtBlackColor(msg: StringConst.yes, fontSize: 17),
          onPressed: () async {
            await SPManager.clearPref();
            Get.offAllNamed(RoutersConst.loginPage);
          }),
      MaterialButton(
          child: getTxtBlackColor(msg: StringConst.no),
          onPressed: () => Get.back()),
    ],
  );
  Get.dialog(widget);
}

showSnackbar(
    {String title = '', String subTitle = '', bool isSuccess = false}) {
  Get.snackbar(title, subTitle,
      backgroundColor: isSuccess ? ColorConst.greyColor : ColorConst.redColor,
      colorText: ColorConst.whiteColor,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3));
}

Widget getCacheImage({
  String url = '',
  String assetPath = '',
  Color? colorPath,
  File? filePath,
  double height = double.infinity,
  double width = double.infinity,
  int placeHolder = 0,
  bool isCircle = false,
  bool isShowBorderRadius = false,
  double borderRadius = 2,
  BoxFit fit = BoxFit.cover,
}) {
  Container imageWidget;
  var border = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(height / 2)),
    border: Border.all(
      color: ColorConst.appColor,
      width: borderRadius,
    ),
  );
  if (colorPath != null) {
    //Only color show in File
    imageWidget = Container(
      width: width,
      height: height,
      color: colorPath,
    );
  } else if (assetPath.isNotEmpty) {
    //Asset File
    imageWidget = Container(
      width: width,
      height: height,
      decoration: isShowBorderRadius ? border : const BoxDecoration(),
      child: Image.asset(assetPath, fit: fit),
    );
  } else if (filePath != null && filePath.path.isNotEmpty) {
    //Local Device File
    imageWidget = Container(
      width: width,
      height: height,
      decoration: isShowBorderRadius ? border : const BoxDecoration(),
      child: ClipOval(child: Image.file(filePath, fit: fit)),
    );
  } else {
    //Image Remote Url
    Widget cacheImg = CachedNetworkImage(
      fit: fit,
      width: width,
      height: height,
      imageUrl: url,
      placeholder: (context, url) => getPlaceHolder(placeHolder, height, width),
      errorWidget: (context, url, error) =>
          getPlaceHolder(placeHolder, height, width),
    );
    imageWidget = Container(
      width: width,
      height: height,
      decoration: isShowBorderRadius ? border : const BoxDecoration(),
      child: isShowBorderRadius ? ClipOval(child: cacheImg) : cacheImg,
    );
  }
  if (isCircle) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: imageWidget,
    );
  } else {
    return imageWidget;
  }
}

Widget getPlaceHolder(int placeHolderPos, double height, double width) {
  switch (placeHolderPos) {
    case 0:
      // LOGO
      return SizedBox(
        width: width,
        height: height,
        child: Image.asset(AssetsConst.logoImg),
      );
    case 1:
      // Grey Shade
      return Container(
        width: width,
        height: height,
        color: Colors.grey[400],
      );
    // case 2:
    //   // Upload
    //   return Container(
    //     width: width,
    //     height: height,
    //     child: Icon(Icons.upload_file),
    //   );
    default:
      return SizedBox(
        width: width,
        height: height,
        child: Image.asset(AssetsConst.logoImg),
      );
  }
}

Widget apiHandler<T>(
    {required ApiResponse<T> response, Widget? loading, Widget? error}) {
  if (response.status == null) {
    return Container();
  } else {
    switch (response.status) {
      case ApiStatus.LOADING:
        return loading ??
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(ColorConst.appColor),
              ),
            );
      case ApiStatus.ERROR:
        return Center(
          child: getTxtColor(
              msg: response.apiError!.errorMessage.toString(),
              txtColor: ColorConst.redColor),
        );
      // return error != null ? error : showError(response.apierror.errorMessage);
      default:
        {
          return Container(
            color: Colors.amber,
            child: getTxtAppColor(msg: StringConst.somethingWentWrong),
          );
        }
    }
  }
}
