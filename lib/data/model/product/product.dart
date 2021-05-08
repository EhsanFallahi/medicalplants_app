class Product {
  int id;
  String title;
  String description;
  int quantity;
  int price;
  int weight;
  List<int> tagsId;
  String picture;
  bool isDisplay;

  Product(
      {this.id,
        this.title,
        this.description,
        this.quantity,
        this.price,
        this.weight,
        this.tagsId,
        this.picture,
        this.isDisplay});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    weight = json['weight'];
    tagsId = json['tag'].cast<int>();
    picture = json['picture'];
    isDisplay = json['is_display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['tag'] = this.tagsId;
    data['picture'] = this.picture;
    data['is_display'] = this.isDisplay;
    return data;
  }
}