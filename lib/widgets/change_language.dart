import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/user/user_controller.dart';
import 'package:medicinalplants_app/translation/localization_service.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/user/dashboard/main_dashboard.dart';

class ChangeLanguage extends StatelessWidget {
  UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: persianText(),
          ),
          Expanded(
            flex: 1,
            child: languageSwitcher(),
          ),
        ],
      ),
    );
  }

  Widget languageSwitcher() {
    return FlutterSwitch(
      height: 20.0,
      width: 40.0,
      padding: 4.0,
      toggleSize: 15.0,
      borderRadius: 10.0,
      activeColor: BUTTON_RED_COLOR,
      value: _userController.isPersianLanguage.value,
      onToggle: (value) {
        _userController.isPersianLanguage.value =
            !_userController.isPersianLanguage.value;
        value
            ? _userController.setPersianLangauge()
            : _userController.serEnglishLanguage();
      },
    );
  }

  Widget persianText() {
    return Text(
      'persian_language'.tr,
      style: TextStyle(
        fontFamily: 'MainFont',
        fontSize: 21,
        color: LABLE_TEXTFORM_COLOR,
      ),
    );
  }
}
