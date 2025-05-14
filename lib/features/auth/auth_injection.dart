import 'package:get_it/get_it.dart';
import 'data/repositories/auth_repository.dart';
import 'presentation/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

void setupAuthDependencies() {
  getIt.registerSingleton<AuthRepository>(AuthRepository());
  getIt.registerFactory(() => AuthCubit(getIt<AuthRepository>()));
}