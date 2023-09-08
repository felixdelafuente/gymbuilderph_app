part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartEvent extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddCartEvent extends CartEvent {
  final int userId;
  final int productId;
  final int quantity;

  const AddCartEvent({
    required this.userId,
    required this.productId,
    required this.quantity,
  });
}

class UpdateCartEvent extends CartEvent {
  final int userId;
  final int productId;
  final int quantity;

  const UpdateCartEvent({
    required this.userId,
    required this.productId,
    required this.quantity,
  });
}

class DeleteCartEvent extends CartEvent {
  final int cartId;

  const DeleteCartEvent({
    required this.cartId,
  });
}