part of 'checkout_bloc.dart';

@immutable
abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrderEvent extends OrderEvent {
  @override
  List<Object> get props => [];
}

class AddOrderEvent extends OrderEvent {
  final int userId;
  final int addressId;
  final String orderDate;
  final double totalAmount;
  final String status;
  final String deliveryStatus;
  final List<ProductsModel> orderItems;

  const AddOrderEvent({
    required this.userId,
    required this.addressId,
    required this.orderDate,
    required this.totalAmount,
    required this.status,
    required this.deliveryStatus,
    required this.orderItems,
  });
}

// class DeleteOrderEvent extends OrderEvent {
//   final int cartId;

//   const DeleteOrderEvent({
//     required this.cartId,
//   });
// }
