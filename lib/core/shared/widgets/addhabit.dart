import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../layout/controller/cubit.dart';
import 'my_button.dart';
import 'myformfield.dart';

class AddHabit extends StatelessWidget {
  final HabitCubit habit;
  final date;

  const AddHabit({super.key, required this.habit, this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    habit.categoryController.text = value.toString();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: MyButton(
                        onPressed: () {
                          if (habit.formKey.currentState!.validate()) {
                            habit.insertDB(
                              title: habit.titleController.text,
                              des: habit.descriptionController.text,
                              category: habit.categoryController.text,
                              date: date,
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
                        style: TextStyle(color: HexColor('#00468C')),
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
    );
  }
}
