import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_trackerr/core/layout/controller/cubit.dart';
import 'package:habit_trackerr/core/layout/controller/state.dart';
import 'package:habit_trackerr/core/shared/widgets/toast/toast_state.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/shared/widgets/addhabit.dart';
import '../../../../core/shared/widgets/my_button.dart';
import '../../../../core/shared/widgets/myformfield.dart';
import '../widgets/generator_home.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HabitCubit, HabitState>(
      listener: (context, state) {
        if(state is InsertDBState){
          showToast(msg: 'Added Successfully', state: ToastStates.success);
        }
        if(state is UpdateTitleDBState){
          showToast(msg: 'Edited Successfully', state: ToastStates.success);
        }
        if(state is UpdateStateDBState){
          showToast(msg: 'state Updated', state: ToastStates.success);
        }
        if(state is DeleteDBState){
          showToast(msg: 'Habit Deleted', state: ToastStates.error);
        }
      },
      builder: (context, state) {
        var habit = HabitCubit.get(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              habit.titleController.clear();
              habit.descriptionController.clear();
              habit.categoryController.text = 'Urgent & Important';
              showDialog(
                context: context,
                builder:
                    (context) => AddHabit(habit: habit),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            backgroundColor: HexColor('#00468C'),
            child: Icon(Icons.add, color: Colors.white),
          ),
          body: ConditionalBuilder(
            condition: habit.filteredHabits.isNotEmpty,
            builder: (context) => GeneratorHome(model: habit.filteredHabits,),
            fallback:
                (context) => Center(
                  child: Icon(Icons.library_books_sharp, size: 100.0, color: Colors.grey),
                ),
          ),
        );
      },
    );
  }
}
