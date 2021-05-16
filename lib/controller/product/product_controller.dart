import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/data/repository/product/product_repository.dart';
import 'package:medicinalplants_app/util/constant.dart';

class ProductController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool searchResult = true.obs;
  double minPrice = double.infinity;
  double maxPrice = 0;
  Rx<RangeValues> rangePrice;

  ProductRepository _productRepository = ProductRepository();
  List<Product> allProduct = [];
  List<Product> validProduct = [];

  @override
  void onInit() {
    getAllProducts();
    super.onInit();
  }

  void getAllProducts() {
    isLoading(true);
    _productRepository.getALlProduct().then((value) {
      if (validateStatusCode(value.statusCode)) {
        List<dynamic> response = value.data as List<dynamic>;
        response.isNotEmpty?
        response.forEach((element) {
          allProduct.add(Product.fromJson(element));
          validProduct.addIf(
              Product.fromJson(element).isDisplay, Product.fromJson(element));
        }):showSnackBar(null, 'no_result_found'.tr, Colors.redAccent);
      }
      findMinMaxPrice();
      isLoading(false);
    });
  }

  void search(String value) {
    isLoading(true);
    validProduct = [];
    allProduct.forEach((element) {
      validProduct.addIf(
          element.isDisplay && element.title.contains(value), element);
    });
    validProduct.isEmpty ? searchResult(false) : searchResult(true);
    isLoading(false);
  }

  void filterSearch() {
    isLoading(true);
      validProduct = [];
      allProduct.forEach((element) {
        validProduct.addIf(
            element.isDisplay &&isPriceInRange(element),
            element);
      });
    validProduct.isEmpty ? searchResult(false) : searchResult(true);
    isLoading(false);
  }

  bool isPriceInRange(Product product) {
    return  product.price <= rangePrice.value.end &&
        product.price >= rangePrice.value.start;
  }

  void findMinMaxPrice() {
    validProduct.forEach((element) {
      if (element.price < minPrice) {
        minPrice = element.price.toDouble();
      }
      if (element.price > maxPrice) {
        maxPrice = element.price.toDouble();
      }
    });
    rangePrice = RangeValues(minPrice, maxPrice).obs;
  }
}
