part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends ProductsEvent {
  @override
  List<Object> get props => [];
}
