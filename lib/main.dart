import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_trackerr/core/layout/controller/cubit.dart';
import 'core/observer/bloc_observer.dart';
import 'features/auth/auth_injection.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // for sharedPreferences run
  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  setupAuthDependencies();


  runApp(MyApp());
  // runApp(
  //         DevicePreview(
  //           enabled: !kReleaseMode,
  //           builder: (context) => MyApp(),
  //         ),
  //     );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>HabitCubit()..createDB()),
        BlocProvider(create: (context) => getIt<AuthCubit>()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoginScreen(),
    ),
    );
  }
}

