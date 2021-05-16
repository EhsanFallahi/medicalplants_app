import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/data/repository/person/person_repository.dart';
import 'package:medicinalplants_app/translation/localization_service.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/user/dashboard/main_dashboard.dart';

class UserController extends GetxController {
  PersonRepository _personRepository = PersonRepository();
  RxBool isLoading = false.obs;
  RxBool isCorrectEnterCurrentPassword = false.obs;
  RxBool isDarkMode = false.obs;
  RxBool isPersianLanguage = true.obs;
  Person person;
  File picture;
  LocalizationService localizationService = LocalizationService();
  GlobalKey<FormState> changePasswordFormKey = GlobalKey();
  GlobalKey<FormState> updateUserFormKey = GlobalKey();
  var userNameController = TextEditingController();
  var fullNameController = TextEditingController();
  var changePasswordController = TextEditingController();

  @override
  void onInit() {
    if(Get.arguments.runtimeType.toString()=='List<Object>'){
      person=Get.arguments[0] as Person;
    }else{person = Get.arguments;}

    userNameController.text = person.userName;
    fullNameController.text = person.fullName;
    super.onInit();
  }

  Future getPicture() async {
    isLoading(true);
    final picker = ImagePicker();
    var selectedPicture = await picker.getImage(source: ImageSource.gallery);
    if (selectedPicture != null) {
      picture = File(selectedPicture.path);
    } else {
      print('please select picture!');
    }
    isLoading(false);
  }

  String toBase64(File file) {
    return base64Encode(file.readAsBytesSync());
  }

  Uint8List fromBase64(String base64) {
    return Base64Decoder().convert(base64);
  }

  updatePassword() {
    if (checkCurrentPassword()) {
      isCorrectEnterCurrentPassword.value = true;
      changePasswordController.text = '';
    }else{
      showSnackBar('', 'wrong_password'.tr, Colors.redAccent);
    }
  }

  saveNewPassword() {
    isLoading(true);
    person.password = changePasswordController.text.trim();
    _personRepository.updatePerson(person).then((value) {
      if (validateStatusCode(value.statusCode)) {
        person = Person.fromJson(value.data);
      } else {
        showSnackBar('network', 'network_error', Colors.redAccent);
      }
    });
    changePasswordController.text = '';
    isCorrectEnterCurrentPassword.value = false;
    isLoading(false);
    Get.back();
  }

  userUpdate() {
    isLoading(true);
    person.fullName = fullNameController.text.trim();
    person.userName = userNameController.text.trim();
    _personRepository.updatePerson(person).then((value) {
      if (validateStatusCode(value.statusCode)) {
        person = Person.fromJson(value.data);
        Get.back();
      } else {
        showSnackBar('network', 'network_error', Colors.redAccent);
      }
      isLoading(false);
    });
  }

  bool checkCurrentPassword() {
    if (changePasswordController.text.trim().isNotEmpty)
      return changePasswordController.text.trim() == person.password;
  }

  setPersianLangauge() =>
      localizationService.changeLocale(LocalizationService.locales[0]);

  serEnglishLanguage() =>
      localizationService.changeLocale(LocalizationService.locales[1]);
}
