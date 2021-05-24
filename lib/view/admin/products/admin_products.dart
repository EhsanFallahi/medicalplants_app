import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/admin/products/admin_productController.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/widgets/item/admin_productItem.dart';

class AdminProducts extends StatelessWidget {
  Person person;

  AdminProducts({this.person});

  AdminProductController _adminProductController =
      Get.put(AdminProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Obx(
            () => _adminProductController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        color: LABLE_TEXTFORM_COLOR,
                      );
                    },
                    itemCount: _adminProductController.allProducts.length,
                    itemBuilder: (_, i) {
                      return AdminProductItem(
                        product: _adminProductController.allProducts[i],
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
