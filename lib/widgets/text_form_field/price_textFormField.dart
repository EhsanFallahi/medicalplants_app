import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/util/constant.dart';

class PriceTextFormField extends StatelessWidget {
  final TextEditingController controller;
  PriceTextFormField({this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15,right: 15,top: 8),
      child: TextFormField(
        style: TextStyle(color: INPUT_TEXTFORM_COLOR),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        maxLength: 6,
        validator: (value) {
          if (value.isEmpty) {
            return 'please_enter_some_text'.tr;
          }
          if (value.length < 5) {
            return 'must_more_than_5_character'.tr;
          } else
            return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: LABLE_TEXTFORM_COLOR, width: 3),
          ),
          labelText: 'price'.tr,
        ),
      ),
    );
  }
}
