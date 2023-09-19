class ProductsModel {
  String? productId;
  String? name;
  String? description;
  String? price;
  String? imageLink;
  String? item;

  ProductsModel(
      {this.productId,
      this.name,
      this.description,
      this.price,
      this.imageLink,
      this.item});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    imageLink = json['image_link'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image_link'] = this.imageLink;
    data['item'] = this.item;
    return data;
  }
}