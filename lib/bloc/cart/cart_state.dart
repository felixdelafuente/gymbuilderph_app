part of 'cart_bloc.dart';

@immutable
sealed class CartState extends Equatable {}

class CartLoadingState extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoadedState<CartModel> extends CartState {
  final CartModel cart;

  CartLoadedState(this.cart);

  @override
  List<Object?> get props => [cart];
}

class CartErrorState extends CartState {
  final String error;

  CartErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
