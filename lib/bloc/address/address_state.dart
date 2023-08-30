part of 'address_bloc.dart';

@immutable
sealed class AddressState extends Equatable {}

class AddressLoadingState extends AddressState {
  @override
  List<Object?> get props => [];
}

class AddressLoadedState<AddressData> extends AddressState {
  final AddressData address;

  AddressLoadedState(this.address);

  @override
  List<Object?> get props => [address];
}

class AddressErrorState extends AddressState {
  final String error;

  AddressErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
