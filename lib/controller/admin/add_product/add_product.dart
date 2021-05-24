import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/admin/products/admin_productController.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/data/repository/product/product_repository.dart';
import 'package:medicinalplants_app/util/constant.dart';

class AddProductController extends GetxController {
  ProductRepository _productRepository = ProductRepository();
  AdminProductController _adminProductController =
      Get.put(AdminProductController());
  Product product;
  RxBool isLoading = false.obs;
  GlobalKey<FormState> formKeyAddProduct = GlobalKey();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var quantityController = TextEditingController();
  var weightController = TextEditingController();
  var tagController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void addProduct(Product product) {
    isLoading(true);
    _productRepository.addProduct(product).then((value) {
      if (validateStatusCode(value.statusCode)) {
        _adminProductController.getAllProduct();
      }
      isLoading(false);
    });
  }
}
