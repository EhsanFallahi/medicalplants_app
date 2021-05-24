import 'package:flutter/material.dart';
import 'package:medicinalplants_app/controller/cart/cart_controller.dart';
import 'package:medicinalplants_app/controller/favorites/favotites_controller.dart';
import 'package:medicinalplants_app/controller/user/user_controller.dart';
import 'package:medicinalplants_app/data/model/cart/cart.dart';
import 'package:medicinalplants_app/data/model/favorites/favorites.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/data/model/purchaseHistory/purchase_history.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/view/user/cart/cart_screen.dart';

class ProductDetails extends StatelessWidget {
  Product product;
  Person person;

  ProductDetails({this.product, this.person});

  FavoritesController _favoritesController = Get.put(FavoritesController());
  CartController _cartController = Get.put(CartController());
  UserController _userController=Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text(
          product.title,
          style: TextStyle(
              fontFamily: 'MainFont',
              fontSize: 24,
              color: INPUT_TEXTFORM_COLOR),
        ));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: mainBody(context),
      ),
    );
  }

  Widget mainBody(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          imageAndIconFavorites(context),
          productTitle(),
          divider(),
          productDescription(),
          divider(),
          productQuantity(),
          divider(),
          rowOfSomeViews(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              product.quantity>0?
              _cartController.onPressedOrderButton.value
                  ? quantityCounter()
                  : orderButton():Text(''),
              _cartController.onPressedOrderButton.value
                  ? TextButton(
                      onPressed: () {
                        _cartController.isOrdered.value?Get.to(()=>CartScreen()):
                        _cartController.addToCart(
                            Cart(userId: person.id, purchaseHistory: [
                              PurchaseHistory(
                                  productId: product.id,
                                  count: _cartController.purchaseQuantity.value)
                            ]),
                            person,
                            product);
                      },
                      child: Text(
                        'add_to_cart'.tr,
                        style: TextStyle(
                            fontFamily: 'MainFont',
                            color: BUTTON_RED_COLOR,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Text('')
            ],
          ),
        ],
      ),
    );
  }

  Widget quantityCounter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 160,
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
                _cartController.incraseQuantity(product);
              },
              color: INPUT_TEXTFORM_COLOR,
            ),
            Obx(
              () => Text(
                _cartController.purchaseQuantity.value.toString(),
                style: TextStyle(
                    color: INPUT_TEXTFORM_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
            ),
            IconButton(
              icon: _cartController.isDeleteProductPurchase.value
                  ? FittedBox(
                    child: IconButton(
                      icon: Icon(
                        Icons.delete_forever_rounded,
                        color: BUTTON_RED_COLOR,
                      ),
                      onPressed: () {
                        _cartController.onPressedOrderButton(false);
                      },
                    ),
                  )
                  : Icon(Icons.remove),
              onPressed: () {
                _cartController.decraseQuantity(product);
              },
              color: INPUT_TEXTFORM_COLOR,
            )
          ],
        ),
      ),
    );
  }

  Widget rowOfSomeViews() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        productWeight(),
        sizedBoxWidth_125(),
        productPrice(),
      ],
    );
  }

  Widget orderButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 140,
          height: 40,
          child: buttonOfOrder(),
        ),
      ),
    );
  }

  Widget buttonOfOrder() {
    return Obx(
      () => FittedBox(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: _cartController.isOrdered.value
                ? Colors.green
                : BUTTON_RED_COLOR, // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {
            _cartController.isOrdered.value?Get.to(()=>CartScreen()):
            _cartController.onPressedOrderButton(true);
          },
          icon: Icon(Icons.add_shopping_cart_rounded),
          label: _cartController.isOrdered.value
              ? Text('available_in_cart'.tr)
              : Text('order'.tr),
        ),
      ),
    );
  }

  Widget productPrice() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: textOfProductPrice(),
    );
  }

  Widget textOfProductPrice() {
    return product.quantity>0?Text(
      '${priceChangeFormat(product.price)}  ' + 'toman'.tr,
      style: TextStyle(
        fontFamily: 'FontFa',
        fontSize: 24,
        color: BUTTON_RED_COLOR,
        fontWeight: FontWeight.bold,
      ),
    ):Text(
      'price_unknown'.tr,
      style: TextStyle(
        fontFamily: 'FontFa',
        fontSize: 24,
        color: BUTTON_RED_COLOR,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget sizedBoxWidth_125() {
    return SizedBox(
      width: 125,
    );
  }

  Widget productWeight() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: textOfProductWeight(),
    );
  }

  Widget textOfProductWeight() {
    return Text(
      'weight'.tr + ' ${product.weight} ' + 'gr'.tr,
      style: TextStyle(
        fontFamily: 'FontFa',
        fontSize: 18,
        color: LABLE_TEXTFORM_COLOR,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget productQuantity() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: product.quantity>0?textOfQuantity():Text(
          'this_product_is_not_available_in_stock'.tr,
          style: TextStyle(
            fontFamily: 'FontFa',
            fontSize: 18,
            color: BUTTON_RED_COLOR,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget textOfQuantity() {
    return Text(
      'quantity'.tr + ' ${product.quantity}',
      style: TextStyle(
        fontFamily: 'FontFa',
        fontSize: 18,
        color: LABLE_TEXTFORM_COLOR,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget productDescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: textOfDescription(),
    );
  }

  Widget textOfDescription() {
    return Text(
      product.description,
      style: TextStyle(
        fontFamily: 'FontFa',
        fontSize: 18,
        color: LABLE_TEXTFORM_COLOR,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget productTitle() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: textOfTitle(),
      ),
    );
  }

  Widget textOfTitle() {
    return Text(
      product.title,
      style: TextStyle(
          fontFamily: 'MainFont',
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: INPUT_TEXTFORM_COLOR),
    );
  }

  Widget imageAndIconFavorites(BuildContext context) {
    return Stack(
      children: [productImage(context), favoritesIcon()],
    );
  }

  Widget favoritesIcon() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => iconButtonHandel(),
      ),
    );
  }

  Widget iconButtonHandel() {
    return IconButton(
      icon: !_favoritesController.isFavorites.value
          ? emptyFavoriteIcon()
          : fullFavoriteIcon(),
      onPressed: () {
        handelIconPressed();
      },
    );
  }

  void handelIconPressed() {
    return _favoritesController.updateFavorites(
        Favorites(userId: person.id, productId: [product.id]), product.id);
  }

  Widget fullFavoriteIcon() {
    return Icon(
      Icons.favorite_rounded,
      color: Colors.redAccent,
      size: 32,
    );
  }

  Widget emptyFavoriteIcon() {
    return Icon(
      Icons.favorite_border_rounded,
      color: Colors.black,
      size: 32,
    );
  }

  Widget productImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: imageContainer(context),
    );
  }

  Widget imageContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: imageLoading(context),
    );
  }

  Widget imageLoading(BuildContext context) {
    return Image.memory(
      _userController.fromBase64(product.picture),
      // product.picture,
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height * 0.35,
      width: double.infinity,
    );
  }
}
