
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_trackerr/core/layout/controller/cubit.dart';

class BuildItemCat extends StatelessWidget {
  final Map model;

  const BuildItemCat({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    bool isDone = model['state'] == 'Yes';
    return Row(
      textBaseline: TextBaseline.alphabetic,
      children: [
        Checkbox(
          value: isDone,
          onChanged:
              (value) =>
              BlocProvider.of<HabitCubit>(
                context,
              ).updateStateDB(id: model['id'], state: value! ? 'Yes' : 'No'),
        ),
        Expanded(
          child: Text(
            model['title'].toString(),
            style: TextStyle(
              color: isDone ? Colors.grey : Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

