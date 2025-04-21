import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/layout/controller/cubit.dart';
import '../../../../core/layout/controller/state.dart';
import '../../../../core/shared/widgets/my_button.dart';
import '../../../../core/shared/widgets/myformfield.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HabitCubit, HabitState>(
      listener: (context, state) {},
      builder: (context, state) {
        var habit = HabitCubit.get(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: habit.formKey,
                    child: AlertDialog(
                      title: Text(
                        'Enter Your Category Details',
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
                            Row(
                              children: [
                                Expanded(
                                  child: MyButton(
                                    onPressed: () {
                                      if (habit.formKey.currentState!
                                          .validate()) {
                                        habit.insertDB(
                                          title: habit.titleController.text,
                                          des: habit.descriptionController.text,
                                        );
                                        Navigator.pop(context);
                                      }
                                    },
                                    text: 'Create Category',
                                    isUpperCase: false,
                                    style: TextStyle(color: Colors.white),
                                    background: HexColor('#00468C'),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: MyButton(
                                    onPressed: () {},
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
        );
      },
    );
  }
}
