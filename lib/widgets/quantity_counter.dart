import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/admin/product_edit/product_editController.dart';
import 'package:medicinalplants_app/util/constant.dart';

class QuantityCounter extends StatelessWidget {
  ProductEditController _productEditController =
      Get.put(ProductEditController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: containerOfCounterItem(),
    );
  }

  Widget containerOfCounterItem() {
    return Container(
      width: 110,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: LABLE_TEXTFORM_COLOR, width: 2),
      ),
      child: rowOfItemsCounter(),
    );
  }

  Widget rowOfItemsCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        addIcon(),
        Obx(
          () => Text(
            _productEditController.quantityCounter.value.toString(),
            style: TextStyle(
                color: INPUT_TEXTFORM_COLOR,
                fontWeight: FontWeight.bold,
                fontSize: 21),
          ),
        ),
        removeIcon()
      ],
    );
  }

  Widget removeIcon() {
    return IconButton(
      icon: Icon(Icons.remove),
      onPressed: () {
        _productEditController.decraseQuantityCounter();
      },
      color: INPUT_TEXTFORM_COLOR,
    );
  }

  Widget addIcon() {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        _productEditController.incraseQuantityCounter();
      },
      color: INPUT_TEXTFORM_COLOR,
    );
  }
}
