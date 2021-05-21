import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/data/repository/product/product_repository.dart';
import 'package:medicinalplants_app/util/constant.dart';

class AdminProductController extends GetxController{
  ProductRepository _productRepository=ProductRepository();
  RxBool isLoading=false.obs;
  Person person;
  List<Product>allProducts=[];

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var quantityController = TextEditingController();
  var weightController = TextEditingController();
  var tagController = TextEditingController();
  GlobalKey<FormState> formKeyEditProduct = GlobalKey();

  @override
  void onInit() {
    getAllProduct();
    super.onInit();
  }

  void getAllProduct(){
    isLoading(true);
    _productRepository.getALlProduct().then((value) {
      if(validateStatusCode(value.statusCode)){
        List<dynamic>response=value.data as List<dynamic>;
        if(response.isNotEmpty){
          response.forEach((element) {
            allProducts.add(Product.fromJson(element));
          });
        }
        print('all product lenght is : ${allProducts.length}');
      }
      isLoading(false);
    });

  }

  String toBase64(File file) {
    return base64Encode(file.readAsBytesSync());
  }

  Uint8List fromBase64(String base64) {
    return Base64Decoder().convert(base64);
  }

}
