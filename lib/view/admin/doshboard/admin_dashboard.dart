import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/admin/add_product/add_product.dart';
import 'package:medicinalplants_app/view/admin/manager/admin_manager.dart';
import 'package:medicinalplants_app/view/admin/products/admin_products.dart';
import 'package:medicinalplants_app/view/user/login/login_screen.dart';

class AdminDashboard extends StatelessWidget {
  Person person;

  AdminDashboard({this.person});

  @override
  Widget build(BuildContext context) {
    return mainBody();
  }

  Widget mainBody() {
    return Scaffold(
        body: Center(
      child: mainColumn(),
    ));
  }

  Widget mainColumn() {
    return Column(
      children: [
        sizedBoxHeight_40(),
        logoImage(),
        sizedBoxHeight_20(),
        textOfAdminPanel(),
        sizedBoxHeight_20(),
        rowOfDashboardButton(),
      ],
    );
  }

  Widget rowOfDashboardButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Column(
        children: [
          adminManager(),
          addProduct(),
        ],
      ),
      Column(
        children: [
          allProducts(),
          adminExit(),
        ],
      ),
    ]);
  }

  Widget adminExit() => createNewDashboardpanel(() {
        Get.off(() => LoginScreen());
      }, Icons.exit_to_app_rounded, 'exit');

  Widget allProducts() => createNewDashboardpanel(() {
        Get.to(() => AdminProducts(
              person: person,
            ));
      }, Icons.shopping_basket_rounded, 'products');

  Widget addProduct() => createNewDashboardpanel(() {
        Get.to(() => AddProduct(
              person: person,
            ));
      }, Icons.add_circle_outline, 'add_product');

  Widget adminManager() => createNewDashboardpanel(() {
        Get.to(() => AdminManager(person: person));
      }, Icons.supervisor_account_rounded, 'admin');

  Widget textOfAdminPanel() {
    return Text(
      'admin_panel'.tr,
      style: TextStyle(
          fontFamily: 'MainFont', fontSize: 49, fontWeight: FontWeight.bold),
    );
  }

  Widget sizedBoxHeight_20() {
    return SizedBox(
      height: 20,
    );
  }

  Widget logoImage() {
    return Image.asset(
      'assets/images/logo.png',
      width: 140,
      height: 140,
      fit: BoxFit.fill,
    );
  }

  Widget sizedBoxHeight_40() {
    return SizedBox(
      height: 40,
    );
  }

  Widget createNewDashboardpanel(
      Function function, IconData panelIcon, String panelName) {
    return GestureDetector(
      onTap: function,
      child: card(panelIcon, panelName),
    );
  }

  Widget card(IconData panelIcon, String panelName) {
    return Card(
      elevation: 10,
      child: container(panelIcon, panelName),
    );
  }

  Widget container(IconData panelIcon, String panelName) {
    return Container(
      width: 160,
      height: 160,
      decoration: boxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            panelIcon,
            size: 81,
            color: Colors.black,
          ),
          textOfPanel(panelName)
        ],
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.black54,
        style: BorderStyle.solid,
        width: 1.0,
      ),
    );
  }

  Widget textOfPanel(String panelName) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Text(
              panelName.tr,
              style: TextStyle(
                  fontFamily: 'MainFont',
                  fontSize: 56,
                  color: LABLE_TEXTFORM_COLOR),
            ),
          ),
        );
  }
}
