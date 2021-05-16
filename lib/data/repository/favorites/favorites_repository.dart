import 'package:dio/dio.dart';
import 'package:medicinalplants_app/data/model/favorites/favorites.dart';

abstract class AbstractFavoritersRepository{
  Future<Response>addFavorites(Favorites favorites);
  Future<Response>deleteFavorites(int id);
  Future<Response>getAllFavorites();
  Future<Response> updateFavorites(Favorites favorites);
  Future<Response> getFavoritesByUserId(int  userId);
  Future<Response> getDesiredProduct(int id);
}
class FavoritesRepository extends AbstractFavoritersRepository{
  Dio _dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:3000/', contentType: 'application/json'));

  @override
  Future<Response> addFavorites(Favorites favorites) {
    return _dio.post('/favorites',data: favorites);
  }

  @override
  Future<Response> deleteFavorites(int id) {
    return _dio.delete('/favorites/$id');
  }

  @override
  Future<Response> getAllFavorites() {
    return _dio.get('/favorites');
  }

  @override
  Future<Response> updateFavorites(Favorites favorites) {
    return _dio.put('/favorites/${favorites.id}', data: favorites);
  }

  @override
  Future<Response> getFavoritesByUserId(int userId) {
      return _dio.get('/favorites/?user_id=$userId');
  }

  @override
  Future<Response> getDesiredProduct(int id) {
    return _dio.get('/product/$id');
  }

}