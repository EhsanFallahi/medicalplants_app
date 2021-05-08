class Baskets {
  int id;
  int userId;
  Map<int,int> purchaseList;
  Baskets({this.id, this.userId});

  Baskets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    purchaseList=json['purchase_list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    return data;
  }
}