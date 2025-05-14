import '../models/register_model.dart';
import '../models/login_model.dart';
import '../../../../core/shared/network/local/database_helper.dart';

class AuthRepository {
  AuthRepository();

  Future<AuthLoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await DatabaseHelper.getUser(email);

      if (user == null) {
        throw AuthException('User not found');
      }

      if (user['password'] != password) {
        throw AuthException('Incorrect password');
      }

      return AuthLoginModel(
        status: true,
        message: 'Login successful',
        data: LoginDataModel(
          id: user['id'],
          name: user['name'],
          email: user['email'],
          phone: user['phone'],
          token: '',
        ),
      );
    } catch (e) {
      throw AuthException('Login failed: ${e.toString()}');
    }
  }

  Future<AuthRegisterModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String dateOfBirth,
  }) async {
    try {
      final existingUser = await DatabaseHelper.getUser(email);
      if (existingUser != null) {
        throw AuthException('Email already registered');
      }

      final user = {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'dateOfBirth': dateOfBirth,
        'isVerified': 1, // Mark as verified immediately
      };

      final id = await DatabaseHelper.addUser(user);

      if (id == 0) {
        throw AuthException('Registration failed');
      }

      return AuthRegisterModel(
        id: id.toString(),
        email: email,
        name: name,
        phone: phone,
        dateOfBirth: dateOfBirth,
      );
    } catch (e) {
      throw AuthException('Registration failed: ${e.toString()}');
    }
  }

  Future<void> clearUserData() async {
    try {
      final db = await DatabaseHelper.getDB();
      await db.delete('User');
      await db.delete('Tasks');
    } catch (e) {
      throw Exception('Failed to clear user data: ${e.toString()}');
    }
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => message;
}
