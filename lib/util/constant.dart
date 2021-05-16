import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

const BACKGROUND_COLOR = Color(0xffeeeeee);
const PADDING_TEXTFORFIELD = EdgeInsets.only(left: 15, right: 15, top: 15);
const FILL_TEXTFORM_COLOR = Colors.black12;
const INPUT_TEXTFORM_COLOR = Colors.black87;
const LABLE_TEXTFORM_COLOR = Colors.black45;
const Button_RED_COLOR = Color(0xff8f0606);

bool validateStatusCode(int statusCode) =>
    statusCode.toString().startsWith('20');

void showSnackBar(String title, String subtitle, Color colorText) =>
    Get.snackbar('$title'.tr, '$subtitle'.tr,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(8),
        colorText: colorText,
        backgroundColor: Colors.black87.withOpacity(0.8));

String priceChangeFormat(int price) {
  NumberFormat numberFormat = NumberFormat.decimalPattern('hi');
  return numberFormat.format(price);
}

Widget divider() {
  return Padding(
    padding: const EdgeInsets.only(left:8.0,right: 8),
    child: Divider(
      color: LABLE_TEXTFORM_COLOR,
      height: 1,
    ),
  );
}