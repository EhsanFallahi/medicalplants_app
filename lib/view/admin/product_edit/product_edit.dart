import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/admin/product/admin_productController.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/widgets/text_form_field/description_textFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/price_textFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/title_textFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/weight_textFormField.dart';

class ProductEdit extends StatelessWidget {
  AdminProductController _adminProductController =
      Get.put(AdminProductController());
  Product product;

  ProductEdit({this.product});

  @override
  Widget build(BuildContext context) {
    initialControllers();
    final appBar = AppBar(
      backgroundColor: Colors.grey,
      centerTitle: true,
      elevation: 0,
      title: Text('product_edit'.tr,
          style: TextStyle(
              fontFamily: 'MainFont',
              fontSize: 24,
              color: INPUT_TEXTFORM_COLOR)),
      // leading: buttonCancelAppBar(),
      // actions: [saveButtonAppBar()],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  image: DecorationImage(
                      image: MemoryImage(
                          _adminProductController.fromBase64(product.picture)),
                      fit: BoxFit.fill,
                      colorFilter: product.isDisplay
                          ? ColorFilter.mode(
                              Colors.black.withOpacity(1), BlendMode.dstATop)
                          : ColorFilter.mode(Colors.black.withOpacity(0.2),
                              BlendMode.dstATop))),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white.withOpacity(0.8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(
                                Icons.delete_forever_rounded,
                                color: BUTTON_RED_COLOR,
                                size: 48,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                icon: Icon(
                                  Icons.visibility_rounded,
                                  color: Colors.lightBlue,
                                  size: 48,
                                ),
                                onPressed: () {}),
                          ),
                          Expanded(flex:2,child: quantityCounter())
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            divider(),
            TitleTextFormField(
                controller: _adminProductController.titleController),
            DescriptionTextFormField(
              controller: _adminProductController.descriptionController,
            ),
            WeightTextFormField(
              controller: _adminProductController.weightController,
            ),
            PriceTextFormField(
              controller: _adminProductController.priceController,
            )
          ],
        ),
      ),
    );
  }

  void initialControllers() {
    _adminProductController.titleController =
        TextEditingController(text: product.title);
    _adminProductController.descriptionController =
        TextEditingController(text: product.description);
    _adminProductController.priceController =
        TextEditingController(text: product.price.toString());
    _adminProductController.weightController =
        TextEditingController(text: product.weight.toString());
  }

  Widget quantityCounter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 110,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: LABLE_TEXTFORM_COLOR, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // _cartController.incraseQuantity(product);
              },
              color: INPUT_TEXTFORM_COLOR,
            ),
            // Obx(
            //   () =>
            Text(
              '3',
              style: TextStyle(
                  color: INPUT_TEXTFORM_COLOR,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
            // ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {},
              color: INPUT_TEXTFORM_COLOR,
            )
          ],
        ),
      ),
    );
  }
}
