import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/user/user_controller.dart';
import 'package:medicinalplants_app/translation/localization_service.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/user/dashboard/main_dashboard.dart';
import 'package:medicinalplants_app/view/user/login/login_screen.dart';

class LogoutButton extends StatelessWidget {
  UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: outLintBtn(),
      ),
    );
  }

  Widget outLintBtn() {
    return OutlineButton(
      onPressed: () {
        Get.offAll(LoginScreen());
      },
      child: logoutText(),
      borderSide: borderSideOfOutlineBtn(),
      shape: roundedRectangleBorder(),
    );
  }

  Widget logoutText() {
    return Text(
      'exit'.tr,
      style: TextStyle(
          fontFamily: 'FontFa', color: INPUT_TEXTFORM_COLOR, fontSize: 18),
    );
  }

  BorderSide borderSideOfOutlineBtn() {
    return BorderSide(
      color: LABLE_TEXTFORM_COLOR,
      width: 2,
    );
  }

  RoundedRectangleBorder roundedRectangleBorder() {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
  }
}
