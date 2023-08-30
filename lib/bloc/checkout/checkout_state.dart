part of 'checkout_bloc.dart';

@immutable
sealed class OrderState extends Equatable {}

class OrderLoadingState extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderLoadedState<OrderModel> extends OrderState {
  final OrderModel order;

  OrderLoadedState(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderErrorState extends OrderState {
  final String error;

  OrderErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
