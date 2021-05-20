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
    allCarts = [];
    allProductIdInCart = [];
    allProductInCart = [];
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
        print('cart product id is :${element.productId}');
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
      print('all cart product is: ${allProductInCart.length}');

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
      _cartRepository.getCartByUserId(person.id).then((value) {
        if (validateStatusCode(value.statusCode)) {
          List<dynamic> response = value.data as List<dynamic>;
          Cart tempCart = Cart.fromJson(response[0]);
          tempCart.purchaseHistory.add(PurchaseHistory(
              productId: product.id, count: cart.purchaseHistory[0].count));
          currentCartUpdate(tempCart);
          isOrdered(true);
          onPressedOrderButton(false);
          Get.to(() => CartScreen());
        } else {
          print('network error');
        }
      });
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

  void currentCartUpdate(Cart cart) {
    // cart=Cart(id: cart.id,userId: person)
    _cartRepository.updateCart(cart).then((value) {
      if (validateStatusCode(value.statusCode)) {
        print('cart updated');
        getAllCarts();
      } else {
        print('network error');
      }
    });
  }

  void deleteFromCart(int productId) {
    isLoading(true);
    _cartRepository.getCartByUserId(person.id).then((value) {
      if (validateStatusCode(value.statusCode)) {
        List<dynamic> response = value.data as List<dynamic>;
        Cart tempCart = Cart.fromJson(response[0]);
        tempCart.purchaseHistory
            .removeWhere((element) => element.productId == productId);
        if (tempCart.purchaseHistory.length == 0) {
          _cartRepository.deleteFromCart(tempCart.id).then((value) {
            if (validateStatusCode(value.statusCode)) {
              print('deleted your cart');
              getAllCarts();
            }
          });
        } else {
          currentCartUpdate(tempCart);
        }
      } else {
        print('network error');
      }
    });
    print('product deleted from cart');
    isLoading(false);
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
      print('puchase is full');
      return 1;
    }
    return purchaseQuantity.value++;
  }

  decraseQuantity(Product product) {
    purchaseQuantity.value--;
    if (purchaseQuantity.value == 1) {
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
    print('total purchase is $tempTotalPurchase');
    totalPurchase.value = tempTotalPurchase;
  }

  void completePurchaseProcess() {
    isLoading(true);
    allCarts.forEach((cart) async {
      for (var i = 0; i < cart.purchaseHistory.length; i++) {
        int productId = cart.purchaseHistory[i].productId;
        await _cartRepository.getDesiredProduct(productId).then((value) {
          if (validateStatusCode(value.statusCode)) {
            Product tempProduct = Product.fromJson(value.data);
            tempProduct.quantity -= cart.purchaseHistory[i].count;
            _productRepository.updateProduct(Product(
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
          } else {
            print('network error');
          }
        });
      }
      deleteAllProductsInCart();
    });
    isLoading(false);
  }

  void deleteAllProductsInCart() {
    isLoading(true);
    print('all cart lentght1 is:${allCarts.length}');
    allCarts.forEach((cart) async {
      await _cartRepository.deleteFromCart(cart.id).then((value) {
        if (validateStatusCode(value.statusCode)) {
          print('person cart is deleted');
          getAllCarts();
          print('all cart lentght2 is:${allCarts.length}');
        } else {
          print('network error');
        }
      });
      if(allCarts.length==0){
        // isOrdered(false);
        _productController.getAllProducts();
        Get.off(
                () => MainDashboard(
              person: person,
            ),
            arguments: person);
      }
    });
    isLoading(false);



  }
}
