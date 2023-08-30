import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gym_builder_app/data/repositories/repository.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressLoadingState()) {
    Repository repository = Repository();
    print("outside LoadAddressEvent working");

    on<LoadAddressEvent>((event, emit) async {
      print("inside LoadAddressEvent working");
      emit(AddressLoadingState());
      try {
        print("inside try AddressLoadingState working");
        final address = await repository.getAddress();
        print("AddressBloc AddressLoadedState: $address");
        emit(AddressLoadedState(address));
      } catch (e) {
        print("AddressBloc AddressErrorState: ${e.toString()}");
        emit(AddressErrorState(e.toString()));
      }
    });

    on<AddAddressEvent>((event, emit) async {
      try {
        print("inside try update MembersBloc working");
        final response = await repository.addAddress(
          event.userId,
          event.addressLine1,
          event.addressLine2,
          event.city,
          event.country,
          event.postalCode,
          event.phoneNumber,
        );
        final address = await repository.getAddress();
        emit(AddressLoadedState(address));
      } catch (e) {
        emit(AddressErrorState(e.toString()));
      }
    });

    on<UpdateAddressEvent>((event, emit) async {
      try {
        print("inside try update MembersBloc working");
        final response = await repository.updateAddress(
          event.addressId,
          event.userId,
          event.addressLine1,
          event.addressLine2,
          event.city,
          event.country,
          event.postalCode,
          event.phoneNumber,
        );
        final address = await repository.getAddress();
        emit(AddressLoadedState(address));
      } catch (e) {
        emit(AddressErrorState(e.toString()));
      }
    });
  }
}
