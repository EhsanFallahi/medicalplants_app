import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/user/user_controller.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/user/dashboard/main_dashboard.dart';


class CancelButtonAppBar extends StatelessWidget {
  UserController _userController = Get.put(UserController());
  Person person;
  CancelButtonAppBar({this.person});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: cancellButton(),
    );
  }

  Widget cancellButton() {
    return IconButton(
      onPressed: () {
        // _userController.userNameController.text='';
        // _userController.fullNameController.text='';
        Get.back();

      },
      icon: Icon(Icons.clear_rounded,color: INPUT_TEXTFORM_COLOR,size: 24,),
    );
  }

}
