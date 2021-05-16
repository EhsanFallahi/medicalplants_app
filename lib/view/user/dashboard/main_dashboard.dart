import 'package:flutter/material.dart';
import 'package:medicinalplants_app/controller/product/product_controller.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/view/user/drawer/main_drawer.dart';
import 'package:medicinalplants_app/widgets/bottom_sheet.dart';
import 'package:medicinalplants_app/widgets/item/product_item.dart';

class MainDashboard extends StatelessWidget {
  Person person;
  MainDashboard({this.person});
  ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      centerTitle: true,
      elevation: 0,
      backgroundColor: FILL_TEXTFORM_COLOR,
      actions: [_cartButtonAppBar()],
      iconTheme: IconThemeData(color: INPUT_TEXTFORM_COLOR),
    );
    return Scaffold(
      appBar: appBar,
      body: mainBody(context),
      drawer: MainDrawer(
        person:person,
      ),
    );
  }

  Widget mainBody(BuildContext context) {
    return Column(
      children: [search(context), advanceSearch(context), productList(context)],
    );
  }

  Widget productList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => _productController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : containerOfListView(context),
      ),
    );
  }

  Widget containerOfListView(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7 - 40,
      child: listView(),
    );
  }

  Widget listView() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
          color: LABLE_TEXTFORM_COLOR,
        );
      },
      itemCount: _productController.validProduct.length,
      itemBuilder: (_, i) {
        return ProductItem(product: _productController.validProduct[i],person: person,);
      },
    );
  }

  Widget advanceSearch(BuildContext context) {
    return containerOfAdvanceSearch(context);
  }

  Widget containerOfAdvanceSearch(BuildContext context) {
    return Obx(
      () => _productController.searchResult.value
          ? Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.topRight,
                  child: textButtonSearch(context),
                ),
              ),
            )
          : Text(
              'no_result_found'.tr,
              style: TextStyle(
                  fontFamily: 'FontFa', color: Button_RED_COLOR, fontSize: 16),
            ),
    );
  }

  Widget textButtonSearch(BuildContext context) {
    return TextButton(
        onPressed: () {
          _modalBottomSheetMenu(context);
        },
        child: Text(
          'advanced_search'.tr,
          style: TextStyle(
              fontFamily: 'FontFa', fontSize: 24, color: Colors.green),
        ));
  }

  Widget search(BuildContext context) {
    return containerOfSearch(context);
  }

  Widget containerOfSearch(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.1,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: EdgeInsets.all(8),
      decoration: SearchBoxDecoration(context),
      child: searchTextField(),
    );
  }

  Widget searchTextField() {
    return TextField(
      onChanged: (value) {
        _productController.search(value);
      },
      decoration: InputDecoration(
          hintText: 'search'.tr,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: Icon(
            Icons.search_rounded,
            color: Colors.black87,
          )),
    );
  }

  BoxDecoration SearchBoxDecoration(BuildContext context) {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 5,
              color: Colors.green.withOpacity(0.8)),
        ]);
  }

  Widget _cartButtonAppBar() {
    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: cartButton(),
    );
  }

  Widget cartButton() {
    return IconButton(
      icon: cartIcon(),
      onPressed: () {},
    );
  }

  Widget cartIcon() {
    return Icon(
      Icons.shopping_cart_sharp,
      size: 24,
    );
  }

  _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return container();
        });
  }

  Widget container() {
    return MyBottomSheet();
  }
}
