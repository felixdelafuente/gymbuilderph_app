class OrderModel {
  String? orderItemId;
  String? orderId;
  String? productId;
  String? quantity;
  String? price;
  String? userId;
  String? addressId;
  String? orderDate;
  String? totalAmount;
  String? status;
  String? deliveryStatus;

  OrderModel(
      {this.orderItemId,
      this.orderId,
      this.productId,
      this.quantity,
      this.price,
      this.userId,
      this.addressId,
      this.orderDate,
      this.totalAmount,
      this.status,
      this.deliveryStatus});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderItemId = json['order_item_id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    userId = json['user_id'];
    addressId = json['address_id'];
    orderDate = json['order_date'];
    totalAmount = json['total_amount'];
    status = json['status'];
    deliveryStatus = json['delivery_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_item_id'] = orderItemId;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['user_id'] = userId;
    data['address_id'] = addressId;
    data['order_date'] = orderDate;
    data['total_amount'] = totalAmount;
    data['status'] = status;
    data['delivery_status'] = deliveryStatus;
    return data;
  }
}
