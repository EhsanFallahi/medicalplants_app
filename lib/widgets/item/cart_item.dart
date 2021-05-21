import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/cart/cart_controller.dart';
import 'package:medicinalplants_app/controller/user/user_controller.dart';
import 'package:medicinalplants_app/data/model/cart/cart.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/data/model/purchaseHistory/purchase_history.dart';
import 'package:medicinalplants_app/util/constant.dart';

class CartItem extends StatelessWidget {
  UserController _userController = Get.put(UserController());
  CartController _cartController = Get.put(CartController());
  Product product;
  PurchaseHistory purchaseHistory;

  CartItem({this.product,this.purchaseHistory});

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // quantityCounter(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'number_of_orders'.tr+': ${purchaseHistory.count}',
                style: TextStyle(
                    fontFamily: 'FontFa', fontSize: 16, color: LABLE_TEXTFORM_COLOR),
              ),
              cancelPurchase(),
              productPrice(),
            ],
          ),
        )
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

  Widget cancelPurchase() {
    return gestureDetectorOfDelete();
  }

  Widget gestureDetectorOfDelete() {
    return GestureDetector(
      onTap: () {
        _cartController.deleteFromCart(product.id);
      },
      child: Row(
        children: [
          iconDelete(),
          textOfCancelPurchase(),
        ],
      ),
    );
  }

  Widget textOfCancelPurchase() {
    return Text(
      'cancel_purchase'.tr,
      style: TextStyle(
          fontFamily: 'MainFont',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: LABLE_TEXTFORM_COLOR),
    );
  }

  Widget iconDelete() {
    return Icon(
      Icons.delete_forever_rounded,
      size: 22,
      color: LABLE_TEXTFORM_COLOR,
    );
  }
}
