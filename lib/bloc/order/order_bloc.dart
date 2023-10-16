import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gym_builder_app/data/models/products_model.dart';
import 'package:gym_builder_app/data/repositories/repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderLoadingState()) {
    Repository repository = Repository();
    print("outside LoadOrderEvent working");

    on<LoadAllOrderEvent>((event, emit) async {
      print("inside LoadAllOrderEvent working");
      emit(OrderLoadingState());
      try {
        print("inside try LoadAllOrderState working");
        final orders = await repository.getAllOrder();
        print("OrderBloc LoadAllOrderState: $orders");
        emit(AllOrderLoadedState(orders));
      } catch (e) {
        print("OrderBloc OrderErrorState: ${e.toString()}");
        emit(OrderErrorState(e.toString()));
      }
    });

    on<LoadOrderEvent>((event, emit) async {
      print("inside LoadOrderEvent working");
      emit(OrderLoadingState());
      try {
        print("inside try OrderLoadingState working");
        final cart = await repository.getOrder();
        print("OrderBloc OrderLoadedState: $cart");
        emit(OrderLoadedState(cart));
      } catch (e) {
        print("OrderBloc OrderErrorState: ${e.toString()}");
        emit(OrderErrorState(e.toString()));
      }
    });

    on<AddOrderEvent>((event, emit) async {
      try {
        print("inside try add order working");
        final response = await repository.addOrder(
          event.userId,
          event.addressId,
          event.orderDate,
          event.totalAmount,
          event.status,
          event.deliveryStatus,
          event.orderItems,
        );
        // final cart = await repository.getOrder();
        emit(OrderLoadedState(response));
      } catch (e) {
        emit(OrderErrorState(e.toString()));
      }
    });

    // on<UpdateOrderEvent>((event, emit) async {
    //   try {
    //     print("inside try update MembersBloc working");
    //     final response = await repository.updateOrder(
    //       event.userId,
    //       event.productId,
    //       event.quantity,
    //     );
    //     final cart = await repository.getOrder();
    //     emit(OrderLoadedState(cart));
    //   } catch (e) {
    //     emit(OrderErrorState(e.toString()));
    //   }
    // });

    on<DeleteOrderEvent>((event, emit) async {
      try {
        print("inside try delete MembersBloc working");
        final response = await repository.deleteOrder(event.orderId);
        final order = await repository.getOrder();
        emit(OrderLoadedState(order));
      } catch (e) {
        emit(OrderErrorState(e.toString()));
      }
    });
  }
}
