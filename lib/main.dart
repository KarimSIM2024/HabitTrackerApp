import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_trackerr/core/layout/controller/cubit.dart';
import 'package:habit_trackerr/core/layout/controller/state.dart';
import 'package:habit_trackerr/core/shared/theme/controller/cubit.dart';
import 'package:habit_trackerr/core/shared/theme/controller/state.dart';
import 'package:habit_trackerr/core/shared/theme/theme_mode.dart';

import 'core/layout/habit_layout.dart';
import 'core/observer/bloc_observer.dart';
import 'core/shared/network/local/cache_helper.dart';
import 'features/home/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // for sharedPresences run
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
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
