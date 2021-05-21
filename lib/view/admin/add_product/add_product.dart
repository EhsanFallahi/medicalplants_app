import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/admin/product/admin_productController.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/widgets/add_photo_device.dart';
import 'package:medicinalplants_app/widgets/text_form_field/description_textFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/price_textFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/quantity_TextFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/title_textFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/weight_textFormField.dart';

class AddProduct extends StatelessWidget {
  AdminProductController _adminProductController=Get.put(AdminProductController());
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
      // leading: buttonCancelAppBar(),
      // actions: [saveButtonAppBar()],
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
            TitleTextFormField(controller: _adminProductController.titleController,),
            DescriptionTextFormField(controller: _adminProductController.descriptionController,),
            WeightTextFormField(controller: _adminProductController.weightController,),
            PriceTextFormField(controller: _adminProductController.priceController,),
            QuantityTextFormField(controller: _adminProductController.quantityController,)
          ],
        ),
      ),
    );
  }

  Widget selectImage(BuildContext context) {
    return AddPhotoDevice();
  }
}
