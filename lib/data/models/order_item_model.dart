class OrderItemModel {
  String? orderItemId;
  String? orderId;
  String? productId;
  String? quantity;
  String? price;

  OrderItemModel(
      {this.orderItemId,
      this.orderId,
      this.productId,
      this.quantity,
      this.price});

  OrderItemModel.fromJson(Map<String, dynamic> json) {
    orderItemId = json['order_item_id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_item_id'] = this.orderItemId;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    return data;
  }
}
