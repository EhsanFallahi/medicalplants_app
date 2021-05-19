import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/user/user_controller.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/user/product_details/product_details.dart';

class ProductItem extends StatelessWidget {
  UserController _userController = Get.put(UserController());
  Product product;
  Person person;

  ProductItem({this.product, this.person});

  @override
  Widget build(BuildContext context) {
    return mainBody();
  }

  Widget mainBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: gestureDetector(),
    );
  }

  Widget gestureDetector() {
    return GestureDetector(
      onTap: () {
        Get.to(() =>
            ProductDetails(
              product: product, person: person,
            ), arguments: [person, product]);
      },
      child: rowOfViews(),
    );
  }

  Widget rowOfViews() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        productInformation(),
        productPicture(),
      ],
    );
  }

  Widget productPicture() => Expanded(flex: 2, child: productImage());

  Widget productInformation() {
    return Expanded(
      flex: 4,
      child: columnOfProductInformation(),
    );
  }

  Widget columnOfProductInformation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        productTitle(),
        sizedBoxHeight_15(),
        productWeight(),
        productPrice(),
      ],
    );
  }

  Widget productPrice() {
    return Text(
      '${priceChangeFormat(product.price)}  ' + 'toman'.tr,
      style: TextStyle(
          fontFamily: 'MainFa',
          fontSize: 18,
          color: LABLE_TEXTFORM_COLOR,
          fontWeight: FontWeight.bold),
    );
  }

  Widget productWeight() {
    return Text(
      '${product.weight}  ' + 'gr'.tr,
      style: TextStyle(
        fontFamily: 'FontFa',
        fontSize: 18,
        color: LABLE_TEXTFORM_COLOR,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget sizedBoxHeight_15() {
    return SizedBox(
      height: 15,
    );
  }

  Widget productTitle() {
    return Text(
      product.title,
      style: TextStyle(
          fontFamily: 'MainFont',
          fontSize: 24,
          color: INPUT_TEXTFORM_COLOR,
          fontWeight: FontWeight.bold),
    );
  }

  Widget productImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.memory(
        _userController.fromBase64(product.picture),
        fit: BoxFit.fill,
        height: 100,
        width: 100,
      ),
    );
  }
}
