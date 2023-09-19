class AddressModel {
  String? addressId;
  String? userId;
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
