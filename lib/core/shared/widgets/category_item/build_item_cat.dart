import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_trackerr/core/layout/controller/cubit.dart';
import 'package:habit_trackerr/core/layout/controller/state.dart';
import 'package:hexcolor/hexcolor.dart';

class BuildItemCat extends StatelessWidget {
  final Map model;

  const BuildItemCat({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HabitCubit, HabitState>(
      listener: (context, state) {},
      builder: (context, state) {
        var habit = HabitCubit.get(context);
        return Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: HexColor('#F7FBFF'),
              border: Border.all(color: HexColor('#00468C')),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    model['title'].toString(),
                    style: TextStyle(
                      color: HexColor('#00468C'),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
