import 'package:bloc/bloc.dart';
import 'package:gym_builder_app/data/repositories/repository.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsLoadingState()) {
    final Repository repository = Repository();

    on<LoadProductsEvent>((event, emit) async {
      print("inside productsLoadedState working");
      emit(ProductsLoadingState());
      try {
        print("inside try productsBloc working");
        final products = await repository.getProducts();
        const message = "Loaded Products";
        emit(ProductsLoadedState(products, message));
      } catch (e) {
        emit(ProductsErrorState("error state: ${e.toString()}"));
      }
    });
  }
}
