import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/util/constant.dart';
class EmailTextFormField extends StatelessWidget {
  final TextEditingController controller;
  EmailTextFormField({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PADDING_TEXTFORFIELD,
      child: TextFormField(
        style: TextStyle(color: INPUT_TEXTFORM_COLOR),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return 'please_enter_some_text'.tr;
          }
          if (value.length < 6) {
            return 'must_more_than_6_characte'.tr;
          } else
            return null;
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: FILL_TEXTFORM_COLOR,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
            BorderSide(color:Colors.green, width: 2),
          ),
          labelText: 'email'.tr,
            labelStyle: TextStyle(
                color: LABLE_TEXTFORM_COLOR
            )
        ),
      ),
    );
  }
}