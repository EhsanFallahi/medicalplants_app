
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/user/user_controller.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/user/dashboard/main_dashboard.dart';


class SaveButtonAppBar extends StatelessWidget {
  UserController _userController = Get.put(UserController());


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: saveButton(),
    );
  }

  Widget saveButton() {
    return IconButton(
      onPressed: () {
        if(_userController.updateUserFormKey.currentState.validate()){
          _userController.userUpdate();
        }
      },
      icon: Icon(Icons.check_rounded,color: INPUT_TEXTFORM_COLOR,size: 24,),
    );
  }

}
