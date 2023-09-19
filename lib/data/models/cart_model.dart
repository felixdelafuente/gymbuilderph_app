import 'package:gym_builder_app/data/models/products_model.dart';

class CartModel {
  String? cartId;
  String? userId;
  String? productId;
  String? quantity;
  String? dateAdded;

  ProductsModel? products;

  CartModel(
      {this.cartId,
      this.userId,
      this.productId,
      this.quantity,
      this.dateAdded,
      this.products});

  CartModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    userId = json['user_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['date_added'] = this.dateAdded;
    return data;
  }
}
