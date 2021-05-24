import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/util/constant.dart';

class WeightTextFormField extends StatelessWidget {
  final TextEditingController controller;
  WeightTextFormField({this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15,right: 15,top: 8),
      child: TextFormField(
        style: TextStyle(color: INPUT_TEXTFORM_COLOR),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: 3,
        validator: (value) {
          if (value.isEmpty) {
            return 'please_enter_some_text'.tr;
          }
          if (value.length < 1) {
            return 'please_enter_some_text'.tr;
          } else
            return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: LABLE_TEXTFORM_COLOR, width: 3),
          ),
          labelText: 'weight'.tr,
        ),
      ),
    );
  }
}
