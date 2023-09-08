class UserModel {
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  int? admin;
  int? verified;

  UserModel(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.admin,
      this.verified});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    admin = json['admin'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['admin'] = admin;
    data['verified'] = verified;
    return data;
  }
}
