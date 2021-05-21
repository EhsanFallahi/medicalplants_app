import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/favorites/favotites_controller.dart';
import 'package:medicinalplants_app/controller/user/user_controller.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/util/constant.dart';

class FavoritesItem extends StatelessWidget {
  FavoritesController _favoritesController = Get.put(FavoritesController());
  UserController _userController = Get.put(UserController());
  Product product;

  FavoritesItem({this.product});

  @override
  Widget build(BuildContext context) {
    return mainBody();
  }

  Widget mainBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: rowOfViews(),
    );
  }

  Widget rowOfViews() {
    return Column(
      children: [
        topRow(),
        bottomRow(),
      ],
    );
  }

  Widget bottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        deleteFromList(),
        productPrice(),
      ],
    );
  }

  Widget topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        productInformation(),
        productPicture(),
      ],
    );
  }

  Widget deleteFromList() {
    return Expanded(
      flex: 1,
      child: gestureDetectorOfDelete(),
    );
  }

  Widget gestureDetectorOfDelete() {
    return GestureDetector(
      onTap: () {
        _favoritesController.deleteFavorites(product.id);
      },
      child: Expanded(
        child: Row(
          children: [
            iconDelete(),
            textOfDeleteFromList(),
          ],
        ),
      ),
    );
  }

  Widget textOfDeleteFromList() {
    return Text(
      'delete_from_list'.tr,
      style: TextStyle(
          fontFamily: 'MainFont',
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: LABLE_TEXTFORM_COLOR),
    );
  }

  Widget iconDelete() {
    return Icon(
      Icons.delete_forever_rounded,
      size: 28,
      color: LABLE_TEXTFORM_COLOR,
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
      ],
    );
  }

  Widget productPrice() {
    return Text(
      '${priceChangeFormat(product.price)}  ' + 'toman'.tr,
      style: TextStyle(
          fontFamily: 'MainFa',
          fontSize: 21,
          color: BUTTON_RED_COLOR,
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
        // product.picture,
        fit: BoxFit.fill,
        height: 100,
        width: 100,
      ),
    );
  }
}
