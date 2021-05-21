import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/user/user_controller.dart';
import 'package:medicinalplants_app/translation/localization_service.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/user/dashboard/main_dashboard.dart';

class ChangePasswordButton extends StatelessWidget {
  UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: BUTTON_RED_COLOR, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          dialogHandler();
        },
        icon: Icon(Icons.edit),
        label: changePassText());
  }

  Widget changePassText() {
    return Text(
      'change_password'.tr,
      style: TextStyle(
        fontFamily: 'FontFa',
        fontSize: 14,
      ),
    );
  }

  Future dialogHandler() {
    return Get.defaultDialog(
        title: 'change_password'.tr,
        titleStyle:
            TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'FontFa'),
        middleTextStyle: TextStyle(fontSize: 21),
        backgroundColor: Colors.black54.withOpacity(0.8),
        radius: 12,
        content: changePasswordForm(),
        textCancel: 'cancel'.tr,
        cancelTextColor: Colors.white,
        onCancel: () {
          Navigator.of(Get.overlayContext).pop();
        },
        textConfirm: 'confirm_password'.tr,
        confirmTextColor: Colors.white,
        onConfirm: () {
          _userController.updatePassword();
          if (checkForPasswordUpdate()) {
            _userController.saveNewPassword();
            Get.back();
          } else {
            print('please enter correct pass');
          }
        });
  }

  bool checkForPasswordUpdate() {
    return _userController.changePasswordFormKey.currentState.validate() &&
        _userController.isCorrectEnterCurrentPassword.value;
  }

  Widget changePasswordForm() {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Form(
            key: _userController.changePasswordFormKey,
            child: textFormField(),
          ),
        ),
      ),
    );
  }

  Widget textFormField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _userController.changePasswordController,
      maxLength: 10,
      style: TextStyle(color: INPUT_TEXTFORM_COLOR),
      validator: (value) {
        if (value.isEmpty) {
          return 'please_enter_some_text'.tr;
        }
        if (value.length < 6) {
          return 'must_be_more_than_6_character'.tr;
        } else
          return null;
      },
      decoration: changePassInputDecoration(),
    );
  }

  InputDecoration changePassInputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.green, width: 2),
      ),
      labelText: !_userController.isCorrectEnterCurrentPassword.value
          ? 'enter_current_password'.tr
          : 'enter_new_password'.tr,
      labelStyle: TextStyle(color: LABLE_TEXTFORM_COLOR, fontFamily: 'FontFa'),
      suffixIcon: Icon(
        Icons.vpn_key_rounded,
        color: INPUT_TEXTFORM_COLOR,
      ),
    );
  }
}
