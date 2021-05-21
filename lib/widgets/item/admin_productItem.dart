import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/admin/product/admin_productController.dart';
import 'package:medicinalplants_app/controller/user/user_controller.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/util/constant.dart';

class AdminProductItem extends StatelessWidget {
  AdminProductController _adminProductController =
  Get.put(AdminProductController());
  Product product;
  AdminProductItem({this.product});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top:8.0,bottom: 8),
      child: GestureDetector(

        child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                image: DecorationImage(
                  image: MemoryImage(_adminProductController.fromBase64(product.picture)),
                    fit: BoxFit.fill,
                    colorFilter: product.isDisplay
                        ? ColorFilter.mode(
                        Colors.black.withOpacity(1), BlendMode.dstATop)
                        : ColorFilter.mode(Colors.black.withOpacity(0.2),
                        BlendMode.dstATop))),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white.withOpacity(0.8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:8.0,right:8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            productTitle(),
                            sizedBoxHeight_15(),
                            productWeight(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0,right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'quantity'.tr + ' ${product.quantity}',
                              style: TextStyle(
                                fontFamily: 'FontFa',
                                fontSize: 18,
                                color: LABLE_TEXTFORM_COLOR,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${priceChangeFormat(product.price)}  ' + 'toman'.tr,
                              style: TextStyle(
                                  fontFamily: 'MainFa',
                                  fontSize: 18,
                                  color: LABLE_TEXTFORM_COLOR,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
      ),
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


}
