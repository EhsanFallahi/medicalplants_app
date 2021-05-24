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
  Product product;
  List<Product>allProducts=[];




  @override
  void onInit() {
    print('get.arguments type is: ${Get.arguments.runtimeType}');
    product=Get.arguments;
    getAllProduct();
    super.onInit();
  }

  void getAllProduct(){
    print('getAll product');
    allProducts=[];
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



}
