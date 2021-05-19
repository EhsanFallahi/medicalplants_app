import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/user/cart/cart_screen.dart';
import 'package:medicinalplants_app/view/user/favorites/favorites_screen.dart';
import 'package:medicinalplants_app/view/user/profile/profile.dart';
import 'package:medicinalplants_app/widgets/change_language.dart';
import 'package:medicinalplants_app/widgets/change_themeMode.dart';
import 'package:medicinalplants_app/widgets/loguot_button.dart';

class MainDrawer extends StatelessWidget {
  Person person;

  MainDrawer({this.person});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: mainBody(context),
    );
  }

  Widget mainBody(BuildContext context) {
    return bodyContainer(context);
  }

  Widget bodyContainer(BuildContext context) {
    return Container(
      color: FILL_TEXTFORM_COLOR,
      child: columnAllItems(context),
    );
  }

  Widget columnAllItems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerDrawer(context),
        divider(),
        logoutBtn(),
        favoritesList(),
        divider(),
        cart(),
        divider(),
        changeThemeMode(),
        divider(),
        changeLanguage(),
        divider(),
        profile(),
        footerText()
      ],
    );
  }

  Widget footerText() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: appTitle(),
      ),
    );
  }

  Widget profile() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextButton(
          onPressed: () {
            Get.to(() => ProfileScreen(), arguments: person);
          },
          child: profileText()),
    );
  }

  Widget profileText() {
    return Text(
      'profile'.tr,
      style: TextStyle(
        fontFamily: 'MainFont',
        fontSize: 21,
        color: LABLE_TEXTFORM_COLOR,
      ),
    );
  }

  Widget changeLanguage() {
    return ChangeLanguage();
  }

  Widget changeThemeMode() {
    return ChangeThemeMode();
  }

  Widget cart() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextButton(
          onPressed: () {
            Get.to(() => CartScreen(), arguments: person);
          },
          child: cartText()),
    );
  }

  Widget cartText() {
    return Text(
      'carts'.tr,
      style: TextStyle(
        fontFamily: 'MainFont',
        fontSize: 21,
        color: LABLE_TEXTFORM_COLOR,
      ),
    );
  }

  Widget favoritesList() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextButton(
          onPressed: () {
            Get.to(() => FavoritesScreen(), arguments: person);
          },
          child: favoriteListText()),
    );
  }

  Widget favoriteListText() {
    return Text(
      'favorites_list'.tr,
      style: TextStyle(
        fontFamily: 'MainFont',
        fontSize: 21,
        color: LABLE_TEXTFORM_COLOR,
      ),
    );
  }

  Widget logoutBtn() {
    return LogoutButton();
  }

  Widget appTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'herbal_store'.tr,
        style: textStyleOfAppTitle(),
      ),
    );
  }

  TextStyle textStyleOfAppTitle() {
    return TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: INPUT_TEXTFORM_COLOR,
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

  Widget headerDrawer(BuildContext context) {
    return containerHeader(context);
  }

  Widget containerHeader(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.35,
        padding: EdgeInsets.all(10),
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.fill,
        ));
  }
}
