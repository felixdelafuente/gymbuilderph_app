class LoginModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? admin;
  String? verified;

  LoginModel(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.admin,
      this.verified});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    admin = json['admin'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['admin'] = this.admin;
    data['verified'] = this.verified;
    return data;
  }
}
