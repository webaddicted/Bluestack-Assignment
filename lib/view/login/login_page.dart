import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tournament/controller/home_controller.dart';
import 'package:tournament/utils/common/validation_helper.dart';
import 'package:tournament/utils/common/widget_helper.dart';
import 'package:tournament/utils/constant/assets_const.dart';
import 'package:tournament/utils/constant/color_const.dart';
import 'package:tournament/utils/constant/routers_const.dart';
import 'package:tournament/utils/constant/string_const.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();
  TextEditingController userNameCont = TextEditingController();
  TextEditingController pwdCont = TextEditingController();
  bool passwordVisible = false;
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConst.whiteColor,
      body: createUi(size),
    );
  }

  Widget createUi(Size size) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            SystemNavigator.pop();
                          }),
                    ),
                    Container(
                        height: 150,
                        width: 150,
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          AssetsConst.logoImg,
                          fit: BoxFit.cover,
                        ))
                  ],
                ),
                getTxtAppColor(
                    msg: StringConst.appName,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 8),
                // getTxtBlackColor(
                //     msg: StringConst.loginYourAccount,
                //     fontSize: 25,
                //     fontWeight: FontWeight.bold),
                // const SizedBox(height: 10),
                Container(
                    alignment: Alignment.center,
                    child: getTxtGreyColor(
                        msg: StringConst.loginDesc,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        textAlign: TextAlign.center)),
                const SizedBox(height: 30),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      edtRectField(
                          control: userNameCont,
                          icons: Icons.person,
                          hint: 'User Name',
                          txtLength: 11,
                          validate: ValidationHelper.validateUserName,
                          keyboardType: TextInputType.text),
                      SizedBox(height: size.height / 60),
                      edtPwdField(
                          control: pwdCont,
                          txtLength: 11,
                          pwdVisible: passwordVisible,
                          pwdVisibleClick: pwdVisClick),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: InkWell(
                      onTap: () {
                        final form = formKey.currentState;
                        if (formKey.currentState!.validate()) {
                          form?.save();
                          validate();
                          // setState(() {});
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        margin: const EdgeInsets.only(right: 20, left: 20),
                        child: Center(
                            child:
                                getTxtWhiteColor(msg: "Login", fontSize: 18)),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            gradient: LinearGradient(
                                colors: [Colors.green, Colors.lightGreen],
                                begin: Alignment.bottomCenter,
                                end: Alignment.bottomLeft,
                                tileMode: TileMode.clamp)),
                      )),
                ),
                const SizedBox(height: 30),
                MaterialButton(
                    onPressed: () {
                      // Get.toNamed(RoutersConst.forgotPwdPage);
                    },
                    child: getTxtAppColor(
                        msg: 'FORGOT PASSWORD?',
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width / 20,
                          right: size.width / 20,
                          top: size.height / 80,
                          bottom: size.height / 100),
                      height: 0.8,
                      color: Colors.black38,
                    ),
                    Center(
                        child: getTxtBlackColor(
                            msg: ' Or continue with ',
                            bgColor: ColorConst.whiteColor))
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: size.height / 20,
                    ),
                    child: InkWell(
                      onTap: () {
                        // Get.toNamed(RoutersConst.signupPage);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          getTxtBlackColor(msg: 'Don\'t have an account?'),
                          getTxtAppColor(
                              msg: ' Sign Up',
                              fontWeight: FontWeight.bold,
                              fontSize: 17)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  pwdVisClick() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  void dispose() {
    super.dispose();
    userNameCont.dispose();
    pwdCont.dispose();
  }

  void validate() {
    var loginIno = "${userNameCont.text.toString().trim()}/${pwdCont.text.toString().trim()}";
    if(loginIno.contains("9898989898/password123")||loginIno.contains("9876543210/password123")) {
      _homeController
          .setUserName(userNameCont.text.toString());
      Get.offAllNamed(RoutersConst.home);
    }else{
      showSnackbar(title: StringConst.error, subTitle: StringConst.invalidUserPwd,isSuccess: false );
    }
    
  }
}
