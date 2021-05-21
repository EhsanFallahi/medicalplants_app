import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/admin/products/admin_products.dart';
import 'package:medicinalplants_app/view/user/login/login_screen.dart';

class AdminDashboard extends StatelessWidget {
  Person person;
  AdminDashboard({this.person});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Image.asset(
            'assets/images/logo.png',
            width: 140,
            height: 140,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'admin_panel'.tr,
            style: TextStyle(
                fontFamily: 'MainFont',
                fontSize: 49,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(
              children: [
                createNewDashboardpanel((){},Icons.supervisor_account_rounded,'admin'),
                createNewDashboardpanel((){},Icons.add_circle_outline,'add_product'),
              ],
            ),
            Column(
              children: [
                createNewDashboardpanel((){Get.to(()=>AdminProducts(person: person,));},Icons.shopping_basket_rounded,'products'),
                createNewDashboardpanel((){Get.off(()=>LoginScreen());},Icons.exit_to_app_rounded,'exit'),
              ],
            ),
          ]),
        ],
      ),
    ));
  }

  Widget createNewDashboardpanel(Function function,IconData panelIcon,String panelName) {
    return GestureDetector(
      onTap: function,
      child: Card(
        elevation: 10,
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black54,
              style: BorderStyle.solid,
              width: 1.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                panelIcon,
                size: 81,
                color: Colors.black,
              ),
              Padding(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
