import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/admin/products/admin_productController.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/data/repository/product/product_repository.dart';
import 'package:medicinalplants_app/util/constant.dart';

class ProductEditController extends GetxController {
  ProductRepository _productRepository = ProductRepository();
  AdminProductController _adminProductController =
      Get.put(AdminProductController());
  RxBool isLoading = false.obs;
  RxInt quantityCounter = 1.obs;
  RxBool isDisplayProduct = true.obs;
  Product product;
  GlobalKey<FormState> formKeyEditProduct = GlobalKey();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var quantityController = TextEditingController();
  var weightController = TextEditingController();
  var tagController = TextEditingController();

  @override
  void onInit() {
    product = Get.arguments;
    isDisplayProduct.value = product.isDisplay;
    quantityCounter.value = product.quantity;
    super.onInit();
  }

  void updateProduct(Product product) {
    isLoading(true);
    _productRepository.updateProduct(product).then((value) {
      if (validateStatusCode(value.statusCode)) {
        print('product updated');
        _adminProductController.getAllProduct();
      } else {
        print('network error');
      }
      isLoading(false);
    });
  }

  void deleteProduct(int productId) {
    isLoading(true);
    _productRepository.deleteProduct(productId).then((value) {
      if (validateStatusCode(value.statusCode)) {
        print('product deleted');
        _adminProductController.getAllProduct();
      }
      isLoading(false);
    });
  }

  incraseQuantityCounter() {
    if (quantityCounter.value > 9999) {
      return;
    }
    quantityCounter.value++;
  }

  decraseQuantityCounter() {
    if (quantityCounter.value < 1) {
      return;
    }
    quantityCounter.value--;
  }
}
