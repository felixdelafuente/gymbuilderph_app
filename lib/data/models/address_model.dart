// ignore_for_file: no_leading_underscores_for_local_identifiers

// class AddressModel {
//   AddressModel({
//     required this.message,
//     required this.data,
//   });
//   late final String message;
//   late final List<AddressData> data;

//   AddressModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     data = List.from(json['data']).map((e) => AddressData.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['message'] = message;
//     _data['data'] = data.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

// class AddressData {
//   AddressData({
//     required this.addressId,
//     required this.userId,
//     required this.addressLine1,
//     required this.addressLine2,
//     required this.city,
//     required this.country,
//     required this.postalCode,
//     required this.phoneNumber,
//   });
//   late final int addressId;
//   late final int userId;
//   late final String addressLine1;
//   late final String addressLine2;
//   late final String city;
//   late final String country;
//   late final String postalCode;
//   late final String phoneNumber;

//   AddressData.fromJson(Map<String, dynamic> json) {
//     addressId = json['address_id'];
//     userId = json['user_id'];
//     addressLine1 = json['address_line1'];
//     addressLine2 = json['address_line2'];
//     city = json['city'];
//     country = json['country'];
//     postalCode = json['postal_code'];
//     phoneNumber = json['phone_number'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['address_id'] = addressId;
//     _data['user_id'] = userId;
//     _data['address_line1'] = addressLine1;
//     _data['address_line2'] = addressLine2;
//     _data['city'] = city;
//     _data['country'] = country;
//     _data['postal_code'] = postalCode;
//     _data['phone_number'] = phoneNumber;
//     return _data;
//   }
// }

class AddressModel {
  int? addressId;
  int? userId;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? country;
  String? postalCode;
  String? phoneNumber;

  AddressModel(
      {this.addressId,
      this.userId,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.country,
      this.postalCode,
      this.phoneNumber});

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    userId = json['user_id'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    country = json['country'];
    postalCode = json['postal_code'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['user_id'] = this.userId;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['city'] = this.city;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}


class AddAddressModel {
  AddAddressModel({
    required this.message,
    required this.addressId,
  });
  late final String message;
  late final String addressId;

  AddAddressModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    addressId = json['address_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['address_id'] = addressId;
    return _data;
  }
}
