// lib/features/auth/presentation/cubit/auth_state.dart
import '../../data/models/register_model.dart';
import '../../data/models/login_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class PasswordVisibilityChanged extends AuthState {}
class ConfirmPasswordVisibilityChanged extends AuthState {}

class LoginLoading extends AuthState {}
class LoginSuccess extends AuthState {
  final AuthLoginModel authModel;
  LoginSuccess(this.authModel);
}
class LoginFailure extends AuthState {
  final String error;
  LoginFailure(this.error);
}

class RegisterLoading extends AuthState {}
class RegisterSuccess extends AuthState {
  final AuthRegisterModel authModel;
  RegisterSuccess(this.authModel);
}
class RegisterFailure extends AuthState {
  final String error;
  RegisterFailure(this.error);
}