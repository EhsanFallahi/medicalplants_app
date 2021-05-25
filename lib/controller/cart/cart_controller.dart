import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/controller/product/product_controller.dart';
import 'package:medicinalplants_app/data/model/cart/cart.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/data/model/purchaseHistory/purchase_history.dart';
import 'package:medicinalplants_app/data/repository/cart/cart_repository.dart';
import 'package:medicinalplants_app/data/repository/product/product_repository.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/user/cart/cart_screen.dart';
import 'package:medicinalplants_app/view/user/dashboard/main_dashboard.dart';

class CartController extends GetxController {
  CartRepository _cartRepository = CartRepository();
  ProductRepository _productRepository = ProductRepository();
  ProductController _productController = Get.put(ProductController());

  RxBool isLoading = false.obs;
  RxBool isOrdered = false.obs;
  RxBool onPressedOrderButton = false.obs;
  RxBool isDeleteProductPurchase = true.obs;
  RxBool isFinishPurchase = false.obs;

  RxInt purchaseQuantity = 1.obs;
  RxDouble totalPurchase = 0.0.obs;
  Person person;
  Product product;
  List<Cart> allCarts = [];
  List<int> allProductIdInCart = [];
  List<Product> allProductInCart = [];

  @override
  void onInit() {
    if (Get.arguments.runtimeType.toString() == 'List<Object>') {
      person = Get.arguments[0] as Person;
      product = Get.arguments[1] as Product;
    } else {
      person = Get.arguments;
    }
    getAllCarts();
    super.onInit();
  }

  void getAllCarts() {
    resetAllList();
    isLoading(true);
    _cartRepository.getAllCarts().then((value) {
      if (validateStatusCode(value.statusCode)) {
        List<dynamic> response = value.data as List<dynamic>;
        if (response.isNotEmpty) {
          response.forEach((cartItem) {
            allCarts.add(Cart.fromJson(cartItem));
          });
          getCurrentUserCart();
        }
      } else {
        print('network error');
      }
    });
    isLoading(false);
  }

  void resetAllList() {
    allCarts = [];
    allProductIdInCart = [];
    allProductInCart = [];
  }

  getCurrentUserCart() {
    allCarts.removeWhere((element) => element.userId != person.id);
    if (allCarts.isEmpty) {
      isLoading(false);
      return;
    }
    getUserProductId();
    getIsOrdered();
    getProductsOfCart();
  }

  void getUserProductId() {
    return allCarts.forEach((cart) {
      cart.purchaseHistory.forEach((element) {
        allProductIdInCart.add(element.productId);
      });
    });
  }

  void getProductsOfCart() {
    isLoading(true);
    allProductIdInCart.forEach((productId) async {
      await _cartRepository.getDesiredProduct(productId).then((value) {
        if (validateStatusCode(value.statusCode)) {
          allProductInCart.add(Product.fromJson(value.data));
        } else {
          print('network error');
        }
      });
      if (allProductIdInCart.length == allProductInCart.length) {
        isLoading(false);
        getTotalPurchase();
      }
    });
  }

  void addToCart(Cart cart, Person person, Product product) {
    isLoading(true);
    allCarts.removeWhere((element) => element.userId != person.id);
    if (allCarts.isNotEmpty) {
      getAndUpdateCartOfCurrentUser(person, product, cart);
    } else {
      _cartRepository.addToCart(cart).then((value) {
        if (validateStatusCode(value.statusCode)) {
          print('add to cart');
          getAllCarts();
          isOrdered(true);
          onPressedOrderButton(false);
          Get.to(() => CartScreen());
        } else {
          print('network error');
        }
      });
    }

    isLoading(false);
  }

  Future<dynamic> getAndUpdateCartOfCurrentUser(
      Person person, Product product, Cart cart) {
    return _cartRepository.getCartByUserId(person.id).then((value) {
      if (validateStatusCode(value.statusCode)) {
        List<dynamic> response = value.data as List<dynamic>;
        Cart tempCart = Cart.fromJson(response[0]);
        tempCart.purchaseHistory.add(PurchaseHistory(
            productId: product.id, count: cart.purchaseHistory[0].count));
        updateCart(tempCart);
      } else {
        print('network error');
      }
    });
  }

  void updateCart(Cart tempCart) {
    currentCartUpdate(tempCart);
    isOrdered(true);
    onPressedOrderButton(false);
    Get.to(() => CartScreen());
  }

  void currentCartUpdate(Cart cart) {
    _cartRepository.updateCart(cart).then((value) {
      if (validateStatusCode(value.statusCode)) {
        getAllCarts();
      } else {
        print('network error');
      }
    });
  }

  void deleteFromCart(int productId) {
    isLoading(true);
    getAndDeleteCart(productId);
    print('product deleted from cart');
    isLoading(false);
  }

  Future<dynamic> getAndDeleteCart(int productId) {
    return _cartRepository.getCartByUserId(person.id).then((value) {
      if (validateStatusCode(value.statusCode)) {
        List<dynamic> response = value.data as List<dynamic>;
        Cart tempCart = Cart.fromJson(response[0]);
        tempCart.purchaseHistory
            .removeWhere((element) => element.productId == productId);
        if (tempCart.purchaseHistory.length == 0) {
          deleteCart(tempCart);
        } else {
          currentCartUpdate(tempCart);
        }
      } else {
        print('network error');
      }
    });
  }

  Future<dynamic> deleteCart(Cart tempCart) {
    return _cartRepository.deleteFromCart(tempCart.id).then((value) {
      if (validateStatusCode(value.statusCode)) {
        isOrdered(false);
        print('deleted your cart');
        getAllCarts();
      }
    });
  }

  void getIsOrdered() {
    if (product != null) {
      int value =
          allProductIdInCart.indexWhere((element) => element == product.id);
      value == -1 ? isOrdered(false) : isOrdered(true);
    }
  }

  incraseQuantity(Product product) {
    isDeleteProductPurchase(false);
    if (purchaseQuantity.value >= product.quantity) {
      // isDeleteProductPurchase(true);
      return 1;
    }
    return purchaseQuantity.value++;
  }

  decraseQuantity(Product product) {
    purchaseQuantity.value--;
    if (purchaseQuantity.value <= 1) {
      isDeleteProductPurchase(true);
      return;
    }
    isDeleteProductPurchase(false);
  }

  getTotalPurchase() {
    double tempTotalPurchase = 0.0;
    allCarts.forEach((cart) {
      for (var i = 0; i < cart.purchaseHistory.length; i++) {
        tempTotalPurchase +=
            cart.purchaseHistory[i].count * allProductInCart[i].price;
      }
    });
    totalPurchase.value = tempTotalPurchase;
  }

  void completePurchaseProcess() {
    isLoading(true);
    allCarts.forEach((cart) async {
      await getAndUpdateProductOfCart(cart);
      deleteAllProductsInCart();
    });
    isLoading(false);
  }

  Future getAndUpdateProductOfCart(Cart cart) async {
    for (var i = 0; i < cart.purchaseHistory.length; i++) {
      int productId = cart.purchaseHistory[i].productId;
      await _cartRepository.getDesiredProduct(productId).then((value) {
        if (validateStatusCode(value.statusCode)) {
          Product tempProduct = Product.fromJson(value.data);
          if (tempProduct.quantity == 0) {
            // handleEmptyQuantity();
            isFinishPurchase(false);
          } else {
            tempProduct.quantity -= cart.purchaseHistory[i].count;
            updateProduct(tempProduct);
            isFinishPurchase(true);
          }
        } else {
          print('network error');
        }
      });
    }
  }

  updateProduct(Product tempProduct) {
    return _productRepository.updateProduct(Product(
      id: tempProduct.id,
      title: tempProduct.title,
      description: tempProduct.description,
      picture: tempProduct.picture,
      price: tempProduct.price,
      weight: tempProduct.weight,
      tagsId: tempProduct.tagsId,
      isDisplay: tempProduct.isDisplay,
      quantity: tempProduct.quantity,
    ));
  }

  void deleteAllProductsInCart() {
    isLoading(true);
    allCarts.forEach((cart) async {
      await deleteCarts(cart);
      finishPurchaseHandel();
    });
    isLoading(false);
  }

  void finishPurchaseHandel() {
    if (allCarts.length == 0) {
      _productController.getAllProducts();
      isOrdered(false);
      onPressedOrderButton(false);
      Get.off(
          () => MainDashboard(
                person: person,
              ),
          arguments: person);
      isFinishPurchase.value
          ? showSnackBar('', 'thanks_for_your_shopping'.tr, Colors.green)
          : showSnackBar('unsuccess_purchase'.tr,
              'this_product_is_not_available_in_stock'.tr, Colors.green);
    }
  }

  Future<dynamic> deleteCarts(Cart cart) async {
    return await _cartRepository.deleteFromCart(cart.id).then((value) {
      if (validateStatusCode(value.statusCode)) {
        getAllCarts();
      } else {
        print('network error');
      }
    });
  }
}
