import 'package:medicinalplants_app/data/model/purchaseHistory/purchase_history.dart';

class Cart {
  int id;
  int userId;
  List<PurchaseHistory> purchaseHistory;

  Cart({
    this.id,
    this.userId,
    this.purchaseHistory,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> userPurchaseHistoryToJson = [];
    if (purchaseHistory != null && purchaseHistory.isNotEmpty) {
      for (PurchaseHistory item in purchaseHistory) {
        userPurchaseHistoryToJson.add(item.toJson());
      }
    }

    return {
      "id": id,
      "user_id": userId,
      "purchase_history": userPurchaseHistoryToJson
    };
  }

  Cart.fromJson(Map<String, dynamic> json) {
    List<PurchaseHistory> userPurchaseHistoryFromJson = [];

    if (json["purchase_history"] != null &&
        json["purchase_history"].length > 0) {
      for (var item in json["purchase_history"]) {
        userPurchaseHistoryFromJson.add(PurchaseHistory.fromJson(item));
      }
    }

    this.id = json["id"];
    this.userId = json["user_id"];
    this.purchaseHistory = userPurchaseHistoryFromJson;
  }
}
