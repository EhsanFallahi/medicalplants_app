import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/product/product_controller.dart';
import 'package:medicinalplants_app/util/constant.dart';

class MyBottomSheet extends StatelessWidget {
  ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
   return Container(
     height: 150.0,
     child: Container(
         margin: EdgeInsets.all(16.0),
         clipBehavior: Clip.antiAlias,
         decoration: BoxDecoration(
           color: Colors.black87.withOpacity(0.8),
           borderRadius: const BorderRadius.all(Radius.circular(16.0)),
         ),
         child: Column(
           children: [
             setPriceRangeText(),
             Obx(
                   () => rangeSlider(),
             ),
             ElevatedButton.icon(
               onPressed: () {
                 _productController.filterSearch();
               },
               style: ElevatedButton.styleFrom(
                 primary: BUTTON_RED_COLOR, // background
                 onPrimary: Colors.white, // foreground
               ),
               icon: Icon(Icons.saved_search),
               label: Text('search'.tr),
             )
           ],
         )),
   );
  }

  Widget rangeSlider() {
    return RangeSlider(
               max: _productController.maxPrice,
               min: _productController.minPrice,
               values: _productController.rangePrice.value,
               divisions: 1000,
               labels: rangeLabels(),
               onChanged: (values) {
                 _productController.rangePrice(values);
               },
             );
  }

  RangeLabels rangeLabels() {
    return RangeLabels(
               priceChangeFormat(_productController
                   .rangePrice.value.start
                   .round()) +
                   ' ' +
                   'toman'.tr,
               priceChangeFormat(_productController
                   .rangePrice.value.end
                   .round()) +
                   ' ' +
                   'toman'.tr,
             );
  }
  Widget setPriceRangeText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'set_price_range'.tr,
        style: TextStyle(
            color: Colors.white70, fontFamily: 'MainFont', fontSize: 18),
      ),
    );
  }

}
