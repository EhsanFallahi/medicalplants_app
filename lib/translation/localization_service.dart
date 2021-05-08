import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:medicinalplants_app/translation/store_translations.dart';

class LocalizationService extends Translations {
  Map<String, String> faIR;
  Map<String, String> enUS;

  static final defaultLocale = locales[0];

  static final fallbackLocale = locales[0];

  static final locales = [
    Locale('fa', 'IR'),
    Locale('en', 'US'),
  ];

  LocalizationService() {
    faIR = {};
    enUS = {};
    faIR.addAll(Locales.fa_IR);
    enUS.addAll(Locales.en_US);
  }

  @override
  Map<String, Map<String, String>> get keys => {'fa_IR': faIR, 'en_US': enUS};

  void changeLocale(Locale locale) {
    Get.updateLocale(locale);
  }
}
