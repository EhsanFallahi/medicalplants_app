import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/favorites/favotites_controller.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/widgets/item/favorites_item.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesController _favoritesController =Get.put(FavoritesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text(
              'favorites'.tr,
              style: TextStyle(
                  fontFamily: 'MainFont',
                  fontSize: 24,
                  color: INPUT_TEXTFORM_COLOR),
            )),
        body: Obx(() => _favoritesController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : containerOfListView(context)
            ));
  }

  Widget containerOfListView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _favoritesController.allFavoritesProduct.isEmpty?Align(
        alignment: Alignment.topCenter,
        child: Text(
          'your_favorites_list_is_empty'.tr,
          style: TextStyle(
              fontFamily: 'FontFa', color: Button_RED_COLOR, fontSize: 16),
        ),
      ):
       Container(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
                color: LABLE_TEXTFORM_COLOR,
              );
            },
            itemCount: _favoritesController.allFavoritesProduct.length,
            itemBuilder: (_, i) {
              return FavoritesItem(
                product: _favoritesController.allFavoritesProduct[i],
              );
            },
          ),
        ),
    );
  }
}
