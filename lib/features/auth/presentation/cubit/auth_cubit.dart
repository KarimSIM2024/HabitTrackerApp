import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityChanged());
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(ConfirmPasswordVisibilityChanged());
  }

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final authModel = await authRepository.login(
        email: email,
        password: password,
      );
      emit(LoginSuccess(authModel)); // In login success
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String dateOfBirth,
  }) async {
    emit(RegisterLoading());
    try {
      final authModel = await authRepository.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
        dateOfBirth: dateOfBirth,
      );
      emit(RegisterSuccess(authModel)); // In register success
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  Future<void> clearData() async {
    emit(AuthLoading()); // Optional: Show loading state
    try {
      await authRepository.clearUserData();
      emit(AuthInitial()); // Reset to initial state after clearing data
    } catch (e) {
      emit(AuthError('Failed to clear data: ${e.toString()}'));
    }
  }
}
