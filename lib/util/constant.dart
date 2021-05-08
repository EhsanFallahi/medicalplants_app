import 'package:flutter/material.dart';
import 'package:get/get.dart';

const BACKGROUND_COLOR=Color(0xffeeeeee);
const PADDING_TEXTFORFIELD=EdgeInsets.only(left: 15, right: 15, top: 15);
const FILL_TEXTFORM_COLOR=Colors.black12;
const INPUT_TEXTFORM_COLOR=Colors.black87;
const LABLE_TEXTFORM_COLOR=Colors.black45;

 bool validateStatusCode(int statusCode) =>
statusCode.toString().startsWith('20');

void showSnackBar(String title,String subtitle,Color colorText) =>
    Get.snackbar('$title'.tr, '$subtitle'.tr,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(8),
        colorText:colorText,
        backgroundColor: Colors.black87.withOpacity(0.8));