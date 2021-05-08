import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/view/user/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Get.off(() => LoginScreen());
    });
    return mainBody();
  }

  Widget mainBody() {
    return Scaffold(
      body: Center(
        child: mainColumn(),
      ),
    );
  }

  Widget mainColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [logo(), appTitle()],
    );
  }

  Widget appTitle() {
    return Text(
      'herbal_store'.tr,
      style: textStyleOfAppTitle(),
    );
  }

  TextStyle textStyleOfAppTitle() {
    return TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.green,
        fontFamily: 'FontFa',
        shadows: [shadowOfAppTitle()]
        // color: Colors.green
        );
  }

  Shadow shadowOfAppTitle() {
    return Shadow(
      offset: Offset(5.0, 5.0),
      blurRadius: 6.0,
      color: Colors.black54,
    );
  }

  Widget logo() {
    return Image.asset(
      'assets/images/logo.png',
      width: 180,
      height: 180,
      fit: BoxFit.fill,
    );
  }
}
