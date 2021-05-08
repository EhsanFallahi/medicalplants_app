import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/login/login_controller.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/user/register/register_screen.dart';
import 'package:medicinalplants_app/widgets/text_form_field/password_txtFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/username_txtFormField.dart';

class LoginScreen extends StatelessWidget {
  LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return mainBody();
  }

  Widget mainBody() {
    return Scaffold(
      body: mainColumn(),
    );
  }

  Widget mainColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [sizedBoxHeight40(), logo(), forms(), loginButton()],
        ),
        registerButton()
      ],
    );
  }

  Widget sizedBoxHeight40() {
    return SizedBox(
      height: 40,
    );
  }

  Widget registerButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: textButton(),
    );
  }

  Widget textButton() {
    return TextButton(
        onPressed: () {
          Get.to(RegisterScreen());
        },
        child: registerText());
  }

  Widget registerText() {
    return Text(
      'register'.tr,
      style: TextStyle(
          fontFamily: 'FontFa', fontSize: 21, color: INPUT_TEXTFORM_COLOR),
    );
  }

  Widget loginButton() {
    return outlineButton();
  }

  Widget outlineButton() {
    return OutlineButton(
      onPressed: () {
        validateInformation() == true
            ? _loginController.loginPerson()
            : showSnackBar('input_error',
                'please_enter_the_information_correctly', Colors.redAccent);
      },
      child: loginText(),
      borderSide: borderSideOfOutlineBtn(),
      shape: roundedRectangleBorder(),
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

  Widget loginText() {
    return Text(
      'login'.tr,
      style: TextStyle(
          fontFamily: 'FontFa', color: INPUT_TEXTFORM_COLOR, fontSize: 18),
    );
  }

  Widget forms() {
    return Form(
      key: _loginController.loginFormKey,
      child: Column(
        children: [
          userNameTextFormField(),
          passwordTextFormField(),
        ],
      ),
    );
  }

  Widget passwordTextFormField() {
    return PasswordTextFormField(
      controller: _loginController.passwordController,
      changeDisplayPassword: _loginController.isDisplayPassword,
    );
  }

  Widget userNameTextFormField() {
    return UserNameTextFormField(
      controller: _loginController.userNameController,
    );
  }

  Widget logo() {
    return Image.asset(
      'assets/images/logo.png',
      width: 150,
      height: 150,
      fit: BoxFit.fill,
    );
  }

  validateInformation() =>
      _loginController.loginFormKey.currentState.validate();
}
