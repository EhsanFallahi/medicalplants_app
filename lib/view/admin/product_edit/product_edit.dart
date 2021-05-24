import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/admin/product_edit/product_editController.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/widgets/cancel_button_appBar.dart';
import 'package:medicinalplants_app/widgets/text_form_field/description_textFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/price_textFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/title_textFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/weight_textFormField.dart';

class ProductEdit extends StatelessWidget {
  ProductEditController _productEditController =
      Get.put(ProductEditController());
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
      leading: buttonCancelAppBar(),
      actions: [saveButtonAppBar()],
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
                      image: MemoryImage(fromBase64(product.picture)),
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
                              onPressed: () {
                                _productEditController
                                    .deleteProduct(product.id);
                                Get.back();
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => IconButton(
                                  icon: _productEditController
                                          .isDisplayProduct.value
                                      ? Icon(
                                          Icons.visibility_rounded,
                                          color: Colors.lightBlue,
                                          size: 48,
                                        )
                                      : Icon(Icons.visibility_off_rounded,
                                          color: Colors.lightBlue, size: 48),
                                  onPressed: () {
                                    _productEditController
                                            .isDisplayProduct.value =
                                        !_productEditController
                                            .isDisplayProduct.value;
                                  }),
                            ),
                          ),
                          Expanded(flex: 2, child: quantityCounter())
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            divider(),
            Form(
              key: _productEditController.formKeyEditProduct,
              child: Column(
                children: [
                  TitleTextFormField(
                      controller: _productEditController.titleController),
                  DescriptionTextFormField(
                    controller: _productEditController.descriptionController,
                  ),
                  WeightTextFormField(
                    controller: _productEditController.weightController,
                  ),
                  PriceTextFormField(
                    controller: _productEditController.priceController,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initialControllers() {
    _productEditController.titleController =
        TextEditingController(text: product.title);
    _productEditController.descriptionController =
        TextEditingController(text: product.description);
    _productEditController.priceController =
        TextEditingController(text: product.price.toString());
    _productEditController.weightController =
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
                _productEditController.incraseQuantityCounter(product);
              },
              color: INPUT_TEXTFORM_COLOR,
            ),
            Obx(
              () => Text(
                _productEditController.quantityCounter.value.toString(),
                style: TextStyle(
                    color: INPUT_TEXTFORM_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                _productEditController.decraseQuantityCounter();
              },
              color: INPUT_TEXTFORM_COLOR,
            )
          ],
        ),
      ),
    );
  }

  Widget buttonCancelAppBar() {
    return CancelButtonAppBar();
  }

  Widget saveButtonAppBar() {
    return saveButtonItem();
  }

  Widget saveButtonItem() {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Obx(
        () => _productEditController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : saveButtonHandel(),
      ),
    );
  }

  Widget saveButtonHandel() {
    return IconButton(
      icon: _productEditController.isLoading.value
          ? CircularProgressIndicator()
          : Icon(
              Icons.check_rounded,
              color: INPUT_TEXTFORM_COLOR,
              size: 24,
            ),
      onPressed: () {
        if (_productEditController.formKeyEditProduct.currentState.validate()) {
          product.title = _productEditController.titleController.text.trim();
          product.description =
              _productEditController.descriptionController.text.trim();
          product.price =
              int.parse(_productEditController.priceController.text.trim());
          product.quantity = _productEditController.quantityCounter.value;
          product.isDisplay = _productEditController.isDisplayProduct.value;
          _productEditController.updateProduct(product);
          Get.back();
        }
      },
    );
  }

  TextStyle textStyleOfCancelText() {
    return TextStyle(
      color: Colors.white,
      decoration: TextDecoration.underline,
      letterSpacing: 1,
      fontSize: 12,
    );
  }
}
