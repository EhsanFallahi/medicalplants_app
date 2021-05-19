import 'package:get/get.dart';
import 'package:medicinalplants_app/translation/localization_service.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:medicinalplants_app/view/user/cart/cart_screen.dart';
import 'package:medicinalplants_app/view/user/dashboard/main_dashboard.dart';
import 'package:medicinalplants_app/view/user/login/login_screen.dart';
import 'package:medicinalplants_app/view/user/profile/profile.dart';
import 'package:medicinalplants_app/view/user/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'herbal_store'.tr,
      debugShowCheckedModeBanner: false,
      locale: LocalizationService.defaultLocale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: BACKGROUND_COLOR,
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'MainFont',
                  fontSize: 20,
                ),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                      fontFamily: 'FontFa',
                      fontSize: 20,
                    ),
                  ))),
      home: LoginScreen(),
    );
  }
}
