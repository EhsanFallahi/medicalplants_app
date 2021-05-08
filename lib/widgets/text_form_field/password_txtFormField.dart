import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/util/constant.dart';

class PasswordTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final RxBool changeDisplayPassword;

  PasswordTextFormField({this.controller, this.changeDisplayPassword});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: PADDING_TEXTFORFIELD,
        child: Obx(
          () => TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: !changeDisplayPassword.value,
            controller: controller,
            maxLength: 10,
            style: TextStyle(color: INPUT_TEXTFORM_COLOR),
            validator: (value) {
              if (value.isEmpty) {
                return 'please_enter_some_text'.tr;
              }
              if (value.length < 6) {
                return 'must_be_more_than_6_character'.tr;
              } else
                return null;
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: FILL_TEXTFORM_COLOR,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
                labelText: 'password'.tr,
                labelStyle: TextStyle(
                    color: LABLE_TEXTFORM_COLOR, fontFamily: 'FontFa'),
                suffixIcon: IconButton(
                    icon: Obx(
                      () => Icon(
                        changeDisplayPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: LABLE_TEXTFORM_COLOR,
                      ),
                    ),
                    onPressed: () {
                      changeDisplayPassword.value =
                          !changeDisplayPassword.value;
                    })),
          ),
        ));
    // ),
    // );
  }
}
