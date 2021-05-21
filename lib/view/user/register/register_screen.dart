import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/login/login_controller.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/widgets/text_form_field/confirm_passwordTxtFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/email_txtFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/fullname_txtFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/password_txtFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/username_txtFormField.dart';

class RegisterScreen extends StatelessWidget {
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
          children: [
            sizedBoxHeight40(),
            logo(),
            forms(),
          ],
        ),
        loginButton()
      ],
    );
  }

  Widget sizedBoxHeight40() {
    return SizedBox(
      height: 40,
    );
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: loginOutlineButton(),
    );
  }

  Widget loginOutlineButton() {
    return Obx(
      () => _loginController.isLoading.value
          ? CircularProgressIndicator()
          : OutlineButton(
              onPressed: () {
                validateInformation() == true
                    ? _loginController.registerPerson()
                    : showSnackBar(
                        'input_error',
                        'please_enter_the_information_correctly',
                        Colors.redAccent);
              },
              child: loginText(),
              borderSide: loginBtnBorderSide(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
    );
  }

  BorderSide loginBtnBorderSide() {
    return BorderSide(
      color: LABLE_TEXTFORM_COLOR,
      width: 2,
    );
  }

  Widget loginText() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Text(
        'login'.tr,
        style: TextStyle(
            fontFamily: 'FontFa', color: INPUT_TEXTFORM_COLOR, fontSize: 21),
      ),
    );
  }

  Widget forms() {
    return Form(
      key: _loginController.registerFormKey,
      child: Column(children: [
        fullNameTextFormField(),
        userNameTextFormField(),
        passwordTextFormField(),
        confirmPasswordTextFormField()
      ]),
    );
  }

  Widget confirmPasswordTextFormField() {
    return ConfirmPasswordTextFormField(
      controller: _loginController.confirmPasswordController,
      changeDisplayPassword: _loginController.isDisplayPassword,
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

  Widget fullNameTextFormField() {
    return FullNameTextFormField(
      controller: _loginController.fullNameController,
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

  bool validateInformation() =>
      _loginController.registerFormKey.currentState.validate() &&
      _loginController.isEqualPasswordAndConfirmPassword();
}
