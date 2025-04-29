
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_trackerr/core/layout/controller/cubit.dart';
import 'package:habit_trackerr/core/layout/controller/state.dart';
import 'core/layout/habit_layout.dart';
import 'core/observer/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // for sharedPresences run
  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
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
    return BlocProvider<HabitCubit>(
      create: (context) => HabitCubit()..createDB(),
      child: BlocConsumer<HabitCubit,HabitState>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home:HabitLayout(),
            );
          }
      ),
    );
  }
}
