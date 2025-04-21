import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_trackerr/core/layout/controller/cubit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../my_button.dart';
import '../myformfield.dart';

class EditDialog extends StatelessWidget {
  final Map model;

  const EditDialog({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final habit = BlocProvider.of<HabitCubit>(context);

    habit.titleController.text = model['title'];
    habit.descriptionController.text = model['description'];
    habit.categoryController.text = model['category'];
    
    return AlertDialog(
      title: Text(
        'Edit Your Task',
        style: TextStyle(
          color: HexColor('#0080FF'),
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: habit.formKey,
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
                    return 'title must not be empty';
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
                value: habit.categoryController.text,
                items: habit.categoryDrop,
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
                          habit.updateDB(
                            id: model['id'],
                            title: habit.titleController.text,
                            des: habit.descriptionController.text,
                            category: habit.categoryController.text,
                          );
                          Navigator.pop(context);
                        }
                      },
                      text: 'Edit Task',
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
    );
  }
}
