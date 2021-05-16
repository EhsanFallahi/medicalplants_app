import 'package:dio/dio.dart';
import 'package:medicinalplants_app/data/model/product/product.dart';

abstract class AbstractProductRepository {
  Future<Response> addProduct(Product product);

  Future<Response> deleteProduct(int id);

  Future<Response> getDesiredProduct(int id);

  Future<Response> getALlProduct();

  Future<Response> updateProduct(Product product);
}

class ProductRepository implements AbstractProductRepository {
  Dio _dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:3000/', contentType: 'application/json'));

  @override
  Future<Response> addProduct(Product product) {
    return _dio.post('/product', data: product);
  }

  @override
  Future<Response> deleteProduct(int id) {
    return _dio.delete('/product/$id');
  }

  @override
  Future<Response> getALlProduct() {
    return _dio.get('/product');
  }

  @override
  Future<Response> getDesiredProduct(int id) {
    return _dio.get('/product/$id');
  }

  @override
  Future<Response> updateProduct(Product product) {
    return _dio.put('/product/${product.id}', data: product);
  }
}
