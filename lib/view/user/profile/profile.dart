import 'package:flutter/material.dart';
import 'package:medicinalplants_app/controller/user/user_controller.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/widgets/cancel_button_appBar.dart';
import 'package:medicinalplants_app/widgets/change_paswordButton.dart';
import 'package:medicinalplants_app/widgets/save_button_appBar.dart';
import 'package:medicinalplants_app/widgets/select_profile_photo.dart';
import 'package:medicinalplants_app/widgets/text_form_field/fullname_txtFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/username_txtFormField.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: BACKGROUND_COLOR,
      leading: saveButtonAppBar(),
      actions: [cancelButtonAppBar()],
    );
    return Scaffold(
      appBar: appBar,
      body: mainBody(context),
    );
  }

  Widget mainBody(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          selectImage(context),
          divider(),
          forms(),
          sizedBoxHeight_42(),
          changePasswordButton(),
        ],
      ),
    );
  }

  Widget changePasswordButton() {
    return ChangePasswordButton();
  }

  SizedBox sizedBoxHeight_42() {
    return SizedBox(
      height: 42,
    );
  }

  Widget forms() {
    return Form(
      key: _userController.updateUserFormKey,
      child: Column(
        children: [
          fullName(),
          userName(),
        ],
      ),
    );
  }

  Widget userName() {
    return UserNameTextFormField(
      controller: _userController.userNameController,
    );
  }

  Widget fullName() {
    return FullNameTextFormField(
      controller: _userController.fullNameController,
    );
  }

  Widget cancelButtonAppBar() {
    return CancelButtonAppBar(person: _userController.person);
  }

  Widget saveButtonAppBar() {
    return SaveButtonAppBar();
  }

  Widget selectImage(BuildContext context) {
    return SelectProfilePhoto();
  }
}
