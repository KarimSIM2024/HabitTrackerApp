
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_trackerr/core/layout/controller/cubit.dart';
import 'package:habit_trackerr/core/layout/controller/state.dart';
import 'package:hexcolor/hexcolor.dart';

class HabitLayout extends StatelessWidget {
  const HabitLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HabitCubit, HabitState>(
      listener: (context, state) {},
      builder: (context, state) {
        var habit = HabitCubit.get(context);
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: HabitCubit.primaryColor,
            unselectedItemColor: HexColor('#000000'),
            type: BottomNavigationBarType.fixed,
            items: HabitCubit.items,
            currentIndex: habit.currentIndex,
            onTap: (index) {
              habit.changeBottomNav(index);
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Matt',
                  style: TextStyle(color: HabitCubit.primaryColor, fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Let\'s Create Your To Do List Now',
                  style: TextStyle(color: HabitCubit.secondaryColor, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Expanded(child: HabitCubit.screens[habit.currentIndex]),
              ],
            ),
          ),
        );
      },
    );
  }
}