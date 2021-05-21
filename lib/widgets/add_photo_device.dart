import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/util/constant.dart';


class AddPhotoDevice extends StatelessWidget {
  // AdminController _adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Stack(
        children: <Widget>[circleAvatar(context), buttonSelectPhoto(context)],
      ),
    );
  }
  Widget buttonSelectPhoto(BuildContext context) {
    return Positioned(bottom: 1, right: 1, child: addPhotoItem(context));
  }

  Widget addPhotoItem(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      child: iconAddPhoto(context),
    );
  }

  Widget iconAddPhoto(BuildContext context) {
    return
      // Obx(
      //     () => _adminController.isLoading.value
      //     ? Center(
      //   child: CircularProgressIndicator(),
      // )
      //     :
      IconButton(
        icon: Icon(
          Icons.add_a_photo_rounded,
          color: BUTTON_RED_COLOR,
        ),
        color: Colors.black,
        onPressed: () {
          // _adminController.getPicture();
        },
      );
    // );
  }

  Widget circleAvatar(BuildContext context) {
    return CircleAvatar(
      backgroundColor: LABLE_TEXTFORM_COLOR,
      radius: 70,
      child: clipOval(),
    );
  }

  Widget clipOval() {
    return ClipOval(
      child: Image.asset(
        '',
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}
