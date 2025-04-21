import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_trackerr/core/layout/controller/cubit.dart';
import 'package:habit_trackerr/core/layout/controller/state.dart';
import 'package:habit_trackerr/core/shared/widgets/myformfield.dart';
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
          key: habit.scaffoldKey,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: HexColor('#00468C'),
            unselectedItemColor: HexColor('#000000'),
            type: BottomNavigationBarType.fixed,
            items: habit.items,
            currentIndex: habit.currentIndex,
            onTap: (index) {
              habit.changeBottomNav(index);
            },
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 65.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Matt',
                  style: TextStyle(color: HexColor('#00468C'), fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Let\'s Create Your To Do List Now',
                  style: TextStyle(color: HexColor('#4B7DAF'), fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Expanded(child: habit.screens[habit.currentIndex]),
              ],
            ),
          ),
        );
      },
    );
  }
}