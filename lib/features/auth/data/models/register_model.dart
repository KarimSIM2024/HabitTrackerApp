class AuthRegisterModel {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String dateOfBirth;

  AuthRegisterModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.dateOfBirth,
  });

  factory AuthRegisterModel.fromJson(Map<String, dynamic> json) {
    return AuthRegisterModel(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? json['date_of_birth'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
    };
  }
}