import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/data/model/favorites/favorites.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';
import 'package:medicinalplants_app/data/repository/favorites/favorites_repository.dart';
import 'package:medicinalplants_app/util/constant.dart';

enum UpdateAction { ADD, DELETE }

class FavoritesController extends GetxController {
  FavoritesRepository _favoritesRepository = FavoritesRepository();
  List<Favorites> allFavorites = [];
  List<Product> allFavoritesProduct = [];
  List<int> allFavoritesProductId = [];

  Person person;
  Product product;
  bool isNotAvalableUser;
  RxBool isLoading = false.obs;
  RxBool isFavorites = false.obs;
  RxBool isFavoritesEmpty = true.obs;

  @override
  void onInit() {
    if (Get.arguments.runtimeType.toString() == 'List<Object>') {
      person = Get.arguments[0] as Person;
      product = Get.arguments[1] as Product;
    } else {
      person = Get.arguments;
    }

    initialAllFavorites();
    super.onInit();
  }

  void initialAllFavorites() {
    allFavorites = [];
    allFavoritesProductId = [];
    allFavoritesProduct = [];
    isLoading(true);
    isAvalableUser(person.id);
    getAllFavorites();
    isLoading(false);
  }

  void getAllFavorites() {
    _favoritesRepository.getAllFavorites().then((value) {
      if (validateStatusCode(value.statusCode)) {
        List<dynamic> response = value.data as List<dynamic>;
        if (response.isEmpty) {
          isFavoritesEmpty(true);
          isLoading(false);
        } else {
          response.forEach((element) {
            allFavorites.add(Favorites.fromJson(element));
          });
          isFavoritesEmpty(false);
          getFavoritesForCurrentUser();
        }
      } else {
        print('network error');
      }
    });
  }

  getFavoritesForCurrentUser() {
    allFavorites.removeWhere((element) => element.userId != person.id);
    print('all favorites user is: ${allFavorites.length}');
    if (allFavorites.isEmpty) {
      isLoading(false);
      isFavoritesEmpty(true);
      return;
    }else if(allFavorites.first.productId.isEmpty){
      isLoading(false);
      isFavoritesEmpty(true);
    }else{
      getUserProductId();
      getIsFavorites();
      getFavoriteProducts();
    }

  }

  void getUserProductId() {
    return allFavorites.forEach((favorites) {
      favorites.productId.forEach((productId) {
        allFavoritesProductId.add(productId);
      });
    });
  }

  void getFavoriteProducts() {
    isLoading(true);
    allFavoritesProductId.forEach((productId) async {
      await _favoritesRepository.getDesiredProduct(productId).then((value) {
        if (validateStatusCode(value.statusCode)) {
          allFavoritesProduct.add(Product.fromJson(value.data));
        } else {
          print('network error');
        }
      });
      if (allFavoritesProductId.length == allFavoritesProduct.length) {
        isLoading(false);
      }
    });
  }

  void updateFavorites(Favorites favorites, int productId) {
    isLoading(true);
    if (!isFavorites.value && isNotAvalableUser) {
      addFavorites(favorites);
      isFavorites(true);
    } else if (!isFavorites.value && favorites.productId.isNotEmpty) {
      updateProductId(favorites, UpdateAction.ADD, productId);
      isFavorites(true);
    } else if (isFavorites.value) {
      updateProductId(favorites, UpdateAction.DELETE, productId);
      isFavorites(false);
    }
    isLoading(false);
  }

  void updateProductId(
      Favorites favorites, UpdateAction updateAction, int productId) {
    _favoritesRepository.getFavoritesByUserId(person.id).then((value) {
      if (validateStatusCode(value.statusCode)) {
        List<dynamic> response = value.data as List<dynamic>;
        Favorites tempFavorites = Favorites.fromJson(response[0]);
        if (updateAction == UpdateAction.ADD) {
          tempFavorites.productId.add(productId);
        }
        if (updateAction == UpdateAction.DELETE) {
          tempFavorites.productId
              .removeWhere((element) => element == productId);
        }
        updateFavoritesInDatabase(tempFavorites);
        isFavorites(false);
      } else {
        print('network error');
      }
    });
  }

  updateFavoritesInDatabase(Favorites favorites) {
    isLoading(true);
    favorites = Favorites(
        id: favorites.id, userId: person.id, productId: favorites.productId);
    _favoritesRepository.updateFavorites(favorites).then((value) {
      if (validateStatusCode(value.statusCode)) {
        initialAllFavorites();
      } else {
        print('network error');
      }
      isLoading(false);
    });
  }

  addFavorites(Favorites favorites) {
    isLoading(true);
    _favoritesRepository.addFavorites(favorites).then((value) {
      if (validateStatusCode(value.statusCode)) {
        initialAllFavorites();
      } else {
        print('network error');
      }
      isLoading(false);
    });
  }

  void deleteFavorites(int productId) {
    updateProductId(allFavorites.first, UpdateAction.DELETE, productId);
  }

  void getIsFavorites() {
    if (product != null) {
      int value =
          allFavoritesProductId.indexWhere((element) => element == product.id);
      value == -1 ? isFavorites(false) : isFavorites(true);
    }
  }

  isAvalableUser(int userId) async {
    isLoading(true);
    await _favoritesRepository.getFavoritesByUserId(userId).then((value) {
      if (validateStatusCode(value.statusCode)) {
        List<dynamic> response = value.data as List<dynamic>;
        if (response.isEmpty) {
          isNotAvalableUser = true;
        } else {
          isNotAvalableUser = false;
        }
      } else {
        print('ntework error!');
      }
      return isNotAvalableUser;
    });
    isLoading(false);
  }
}
