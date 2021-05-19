import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/cart/cart_controller.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/widgets/item/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartController _cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey,
            centerTitle: true,
            title: Text(
              'carts'.tr,
              style: TextStyle(
                  fontFamily: 'MainFont',
                  fontSize: 24,
                  color: INPUT_TEXTFORM_COLOR),
            )),
        body: Obx(() => _cartController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : containerOfListView(context)));
  }

  Widget containerOfListView(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _cartController.allProductInCart.isEmpty
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'your_cart_list_is_empty'.tr,
                    style: TextStyle(
                        fontFamily: 'FontFa',
                        color: Button_RED_COLOR,
                        fontSize: 16),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 8, bottom: 8),
                        child: Divider(
                          height: 1,
                          color: LABLE_TEXTFORM_COLOR,
                        ),
                      );
                    },
                    itemCount: _cartController.allProductInCart.length,
                    itemBuilder: (_, i) {
                      return CartItem(
                          product: _cartController.allProductInCart[i],
                          purchaseHistory:
                              _cartController.allCarts[0].purchaseHistory[i]);
                    },
                  ),
                ),
        ),
        divider(),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: _cartController.allProductInCart.isEmpty
              ? Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.fill,
                    width: 120,
                    height: 120,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 140,
                      child: FittedBox(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Button_RED_COLOR, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {_cartController.completePurchaseProcess();},
                          icon: Icon(Icons.add_shopping_cart_rounded),
                          label: Text('complete_the_purchase_process'.tr),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            'the_amount_payable'.tr,
                            style: TextStyle(
                                fontFamily: 'MainFont',
                                color: LABLE_TEXTFORM_COLOR,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Obx(()=>FittedBox(
                          child: Text(
                              '${priceChangeFormat(_cartController.totalPurchase.value.toInt())}  ' +
                                  'toman'.tr,
                              style: TextStyle(
                                  fontFamily: 'FontFa',
                                  color: Colors.black,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold),
                            ),
                        ),
                        )
                      ],
                    )
                  ],
                ),
        )
      ],
    );
  }
// }
}
