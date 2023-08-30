part of 'products_bloc.dart';

@immutable
sealed class ProductsState extends Equatable {}

class ProductsLoadingState extends ProductsState {
  @override
  List<Object?> get props => [];
}

class ProductsLoadedState<ProductsModel> extends ProductsState {
  final ProductsModel products;
  final dynamic message;

  ProductsLoadedState(this.products, this.message);

  @override
  List<Object?> get props => [products];
}

class ProductsErrorState extends ProductsState {
  final String error;

  ProductsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
