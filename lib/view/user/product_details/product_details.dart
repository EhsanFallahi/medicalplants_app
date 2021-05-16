import 'package:flutter/material.dart';
import 'package:medicinalplants_app/controller/favorites/favotites_controller.dart';
import 'package:medicinalplants_app/controller/user/user_controller.dart';
import 'package:medicinalplants_app/data/model/favorites/favorites.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  Product product;
  Person person;

  ProductDetails({this.product, this.person});

  FavoritesController _favoritesController = Get.put(FavoritesController());
  UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final appBar=AppBar(
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
      appBar:appBar,
      body: SingleChildScrollView(
        child: mainBody(context),
      ),
    );
  }

  Widget mainBody(BuildContext context) {
    return Column(
      children: [
        imageAndIconFavorites(context),
        productTitle(),
        divider(),
        productDescription(),
        divider(),
        productQuantity(),
        divider(),
        rowOfSomeViews(),
        orderButton()
      ],
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
          width: 100,
          height: 40,
          child: buttonOfOrder(),
        ),
      ),
    );
  }

  Widget buttonOfOrder() {
    return ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Button_RED_COLOR, // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {},
          icon: Icon(Icons.add_shopping_cart_rounded),
          label: Text('order'.tr),
        );
  }

  Widget productPrice() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: textOfProductPrice(),
    );
  }

  Widget textOfProductPrice() {
    return Text(
      '${priceChangeFormat(product.price)}  ' + 'toman'.tr,
      style: TextStyle(
        fontFamily: 'FontFa',
        fontSize: 24,
        color: Button_RED_COLOR,
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
        child: textOfQuantity(),
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
            Favorites(userId: person.id, productId: [product.id]),
            product.id);
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
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height * 0.35,
      width: double.infinity,
    );
  }
}
