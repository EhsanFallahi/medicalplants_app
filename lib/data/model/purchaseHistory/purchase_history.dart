class PurchaseHistory {
  int productId;
  int count;

  PurchaseHistory({this.productId, this.count});

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "count": count,
    };
  }

  PurchaseHistory.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    count = json["count"];
  }
}
