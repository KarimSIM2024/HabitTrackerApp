import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_trackerr/core/layout/controller/cubit.dart';
import 'package:habit_trackerr/core/layout/controller/state.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/shared/widgets/my_button.dart';
import '../../../../core/shared/widgets/myformfield.dart';
import '../widgets/generator_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HabitCubit, HabitState>(
      listener: (context, state) {},
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
                    (context) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: habit.formKey,
                        child: AlertDialog(
                          title: Text(
                            'Enter Your Task Details',
                            style: TextStyle(
                              color: HexColor('#0080FF'),
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Title',
                                  style: TextStyle(
                                    color: HexColor('#00468C'),
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                MyFormField(
                                  controller: habit.titleController,
                                  type: TextInputType.text,
                                  prefix: Icons.title,
                                  isUpperCase: false,
                                  text: 'ex: do math homework',
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Description',
                                  style: TextStyle(
                                    color: HexColor('#00468C'),
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                MyFormField(
                                  controller: habit.descriptionController,
                                  type: TextInputType.text,
                                  prefix: Icons.description,
                                  isUpperCase: false,
                                  text: 'ex: Math Homework',
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Description must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Category',
                                  style: TextStyle(
                                    color: HexColor('#00468C'),
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                DropdownButtonFormField(
                                  isExpanded: true,
                                  value: habit.categoryController.text,
                                  items: HabitCubit.categoryDrop,
                                  onChanged: (value) {
                                    habit.categoryController.text =
                                        value.toString();
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyButton(
                                        onPressed: () {
                                          if (habit.formKey.currentState!
                                              .validate()) {
                                            habit.insertDB(
                                              title: habit.titleController.text,
                                              des:
                                                  habit
                                                      .descriptionController
                                                      .text,
                                              category:
                                                  habit.categoryController.text,
                                            );
                                            Navigator.pop(context);
                                          }
                                        },
                                        text: 'Create Task',
                                        isUpperCase: false,
                                        style: TextStyle(color: Colors.white),
                                        background: HexColor('#00468C'),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Expanded(
                                      child: MyButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        text: 'Cancel',
                                        isUpperCase: false,
                                        style: TextStyle(
                                          color: HexColor('#00468C'),
                                        ),
                                        background: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            backgroundColor: HexColor('#00468C'),
            child: Icon(Icons.add, color: Colors.white),
          ),
          body: ConditionalBuilder(
            condition: habit.habits.isNotEmpty,
            builder: (context) => GeneratorHome(tasks: habit.habits),
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
