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

// class CartEvent {
//   // // A named constructor for the CartEvent.add event
//   // const CartEvent.add(this.product);

//   // // A named constructor for the CartEvent.remove event
//   // const CartEvent.remove(this.product);

//   // // A named constructor for the CartEvent.clear event
//   // const CartEvent.clear(this.product);

//   // // A property to store the product information
//   // final ProductsModel? product;
// }

// class AddCartEvent extends CartEvent {
//   final ProductsModel product;

//   AddCartEvent({required this.product});
// }

// class RemoveCartEvent extends CartEvent {
//   final ProductsModel product;

//   RemoveCartEvent({required this.product});
// }

// class ClearCartEvent extends CartEvent {
//   final ProductsModel product;

//   ClearCartEvent({required this.product});
// }
