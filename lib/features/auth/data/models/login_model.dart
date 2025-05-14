class AuthLoginModel {
  final bool status;
  final String message;
  final LoginDataModel? data;

  AuthLoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AuthLoginModel.fromJson(Map<String, dynamic> json) {
    return AuthLoginModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? LoginDataModel.fromJson(json['data']) : null,
    );
  }
}

class LoginDataModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String token;

  LoginDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      token: json['token'],
    );
  }
}