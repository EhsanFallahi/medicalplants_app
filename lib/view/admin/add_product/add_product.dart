import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/admin/add_product/add_product.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/admin/products/admin_products.dart';
import 'package:medicinalplants_app/widgets/add_photo_device.dart';
import 'package:medicinalplants_app/widgets/cancel_button_appBar.dart';
import 'package:medicinalplants_app/widgets/text_form_field/description_textFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/price_textFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/quantity_TextFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/title_textFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/weight_textFormField.dart';

class AddProduct extends StatelessWidget {
  Person person;
  AddProduct({this.person});
  AddProductController _addProductController=Get.put(AddProductController());
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.grey,
      centerTitle: true,
      elevation: 0,
      title: Text('add_product'.tr,
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
            selectImage(context),
            Padding(
              padding: const EdgeInsets.all(20),
              child: divider(),
            ),
            Form(
              key: _addProductController.formKeyAddProduct,
              child: Column(
                children: [
                  TitleTextFormField(controller: _addProductController.titleController,),
                  DescriptionTextFormField(controller: _addProductController.descriptionController,),
                  WeightTextFormField(controller: _addProductController.weightController,),
                  PriceTextFormField(controller: _addProductController.priceController,),
                  QuantityTextFormField(controller: _addProductController.quantityController,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectImage(BuildContext context) {
    return AddPhotoDevice();
  }
  Widget cancellButton() {
    return CancelButtonAppBar();
  }


  Widget saveButtonAppBar() {
    return saveButtonItem();
  }

  Widget saveButtonItem() {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Obx(
            () => _addProductController.isLoading.value
            ? Center(
          child: CircularProgressIndicator(),
        )
            : saveButtonHandel(),
      ),
    );
  }

  Widget saveButtonHandel() {
    return IconButton(
      icon: _addProductController.isLoading.value
          ? CircularProgressIndicator()
          : Icon(
        Icons.check_rounded,
        color: INPUT_TEXTFORM_COLOR,
        size: 24,
      ),
      onPressed: () {
        if (_addProductController.formKeyAddProduct.currentState.validate()) {
          _addProductController.addProduct(Product(
            title: _addProductController.titleController.text.trim(),
            description: _addProductController.descriptionController.text.trim(),
            weight: int.parse(_addProductController.weightController.text.toString().trim()),
            quantity: int.parse(_addProductController.quantityController.text.toString().trim()),
            price: int.parse(_addProductController.priceController.text.toString().trim()),
            isDisplay: true,
            tagsId: [],
            picture: tempProductImage
          ));
          Get.off(()=>AdminProducts(person: person,));
        }
      },
    );
  }

  Widget buttonCancelAppBar() {
    return CancelButtonAppBar();
  }
}
