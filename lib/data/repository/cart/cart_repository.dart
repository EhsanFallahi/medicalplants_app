import 'package:dio/dio.dart';
import 'package:medicinalplants_app/data/model/cart/cart.dart';

abstract class AbstractCartRepository{
  Future<Response>addToCart(Cart cart);
  Future<Response>deleteFromCart(int id);
  Future<Response>getAllCarts();
  Future<Response> updateCart(Cart cart);
  Future<Response> getCartByUserId(int  userId);
  Future<Response> getDesiredProduct(int id);
}
class CartRepository extends AbstractCartRepository{
  Dio _dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:3000/', contentType: 'application/json'));
  @override
  Future<Response> addToCart(Cart cart) {
    return _dio.post('/cart',data: cart);
  }

  @override
  Future<Response> deleteFromCart(int id) {
    return _dio.delete('/cart/$id');
  }

  @override
  Future<Response> getAllCarts() {
    return _dio.get('/cart');
  }

  @override
  Future<Response> getCartByUserId(int userId) {
    return _dio.get('/cart/?user_id=$userId');
  }

  @override
  Future<Response> getDesiredProduct(int id) {
    return _dio.get('/product/$id');
  }

  @override
  Future<Response> updateCart(Cart cart) {
    return _dio.put('/cart/${cart.id}', data: cart);
  }

}