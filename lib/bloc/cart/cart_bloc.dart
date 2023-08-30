import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_builder_app/data/repositories/repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoadingState()) {
    Repository repository = Repository();
    print("outside LoadCartEvent working");

    on<LoadCartEvent>((event, emit) async {
      print("inside LoadCartEvent working");
      emit(CartLoadingState());
      try {
        print("inside try CartLoadingState working");
        final cart = await repository.getCart();
        print("CartBloc CartLoadedState: $cart");
        emit(CartLoadedState(cart));
      } catch (e) {
        print("CartBloc CartErrorState: ${e.toString()}");
        emit(CartErrorState(e.toString()));
      }
    });

    on<AddCartEvent>((event, emit) async {
      try {
        print("inside try update MembersBloc working");
        final response = await repository.addCart(
          event.userId,
          event.productId,
          event.quantity,
        );
        final cart = await repository.getCart();
        emit(CartLoadedState(cart));
      } catch (e) {
        emit(CartErrorState(e.toString()));
      }
    });

    on<UpdateCartEvent>((event, emit) async {
      try {
        print("inside try update MembersBloc working");
        final response = await repository.updateCart(
          event.userId,
          event.productId,
          event.quantity,
        );
        final cart = await repository.getCart();
        emit(CartLoadedState(cart));
      } catch (e) {
        emit(CartErrorState(e.toString()));
      }
    });

    on<DeleteCartEvent>((event, emit) async {
      try {
        print("inside try delete MembersBloc working");
        final response = await repository.deleteCart(event.cartId);
        final cart = await repository.getCart();
        emit(CartLoadedState(cart));
      } catch (e) {
        emit(CartErrorState(e.toString()));
      }
    });
  }
}



// // class CartBloc extends Bloc<CartEvent, CartState> {
// //   CartBloc() : super(CartInitial()) {
// //     on<CartEvent>((event, emit) {
// //     });
// //   }
// // }

// class CartBloc extends Bloc<CartEvent, CartState> {
//   // The initial state is an empty list
//   CartBloc() : super(CartState([]));

//   Stream<CartState> mapEventToState(CartEvent event) async* {
//     // Depending on the event type, yield a new state
//     // if (event is CartEvent.add) {
//     //   // Add a new item to the cart list
//     //   List<CartModel> newState = List.from(state.items);
//     //   newState.add(CartModel(product: event.product));
//     //   yield CartState(newState);
//     // } else if (event is CartEvent.remove) {
//     //   // Remove an item from the cart list
//     //   List<CartModel> newState = List.from(state.items);
//     //   newState.removeWhere((item) => item.product == event.product);
//     //   yield CartState(newState);
//     // } else if (event is CartEvent.clear) {
//     //   // Clear the cart list
//     //   yield CartState([]);
//     // }

//     on<AddCartEvent>((event, emit) async {
//       print("inside AddCartEvent working");
//       // Add a new item to the cart list
//       List<CartModel> newState = List.from(state.items);
//       newState.add(CartModel(product: event.product));
//       emit(CartState(newState));
//       // try {
//       //   print("inside try MembersBloc working");
//       //   final members = await customersRepository.getCustomers();
//       //   const message = "Loaded customers";
//       //   emit(CustomersLoadedState(members, message));
//       // } catch (e) {
//       //   emit(CustomersErrorState(e.toString()));
//       // }
//     });

//     on<RemoveCartEvent>((event, emit) async {
//       print("inside RemoveCartEvent working");
//       // Remove an item from the cart list
//       List<CartModel> newState = List.from(state.items);
//       newState.removeWhere((item) => item.product == event.product);
//       emit(CartState(newState));
//     });

//     on<ClearCartEvent>((event, emit) async {
//       print("inside ClearCartEvent working");
//       // Clear the cart list
//       emit(CartState([]));
//     });
//   }
// }
