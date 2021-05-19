import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/user/user_controller.dart';
import 'package:medicinalplants_app/util/constant.dart';

class SelectProfilePhoto extends StatelessWidget {
  UserController _userController=Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          circleAvatar(context),
          changeProfilePhotoBtn()
        ],
      ),
    );
  }

  Widget changeProfilePhotoBtn() {
    return Obx(()=>_userController.isLoading.value?Center(
      child: CircularProgressIndicator(),
    ): TextButton(
              onPressed: () {_userController.getPicture();},
              child: Text(
                'change_profile_photo'.tr,
                style: TextStyle(
                    fontFamily: 'MainFont',
                    fontSize: 20,
                    color: INPUT_TEXTFORM_COLOR,
                    fontWeight: FontWeight.bold),
              )),
    );
  }

  Widget circleAvatar(BuildContext context) {
    return CircleAvatar(
      backgroundColor: LABLE_TEXTFORM_COLOR,
      radius: 50,
      child: clipOval(),
    );
  }

  Widget clipOval() {
    return ClipOval(
      child: Image.asset(
        '',
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
