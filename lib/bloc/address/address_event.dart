part of 'address_bloc.dart';

@immutable
abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class LoadAddressEvent extends AddressEvent {
  @override
  List<Object> get props => [];
}

class AddAddressEvent extends AddressEvent {
  final int userId;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String country;
  final String postalCode;
  final String phoneNumber;

  const AddAddressEvent({
    required this.userId,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.postalCode,
    required this.phoneNumber,
  });
}

class UpdateAddressEvent extends AddressEvent {
  final int addressId;
  final int userId;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String country;
  final String postalCode;
  final String phoneNumber;

  const UpdateAddressEvent({
    required this.addressId,
    required this.userId,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.postalCode,
    required this.phoneNumber,
  });
}
