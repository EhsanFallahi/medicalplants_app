import 'dart:convert'show JSON;
class Favorites {
  int id;
  int userId;
  List<int> productId;

  Favorites({this.id, this.userId, this.productId});

  Favorites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    return data;
  }
}