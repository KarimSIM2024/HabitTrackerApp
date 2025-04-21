import 'package:flutter/material.dart';
import 'build_item_home.dart';


class GeneratorHome extends StatelessWidget {
  final List tasks;
  const GeneratorHome({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isNotEmpty) {
      return ListView.separated(
        itemBuilder: (context, index) => BuildItemHome(model: tasks[index],),
        separatorBuilder: (context, index) => SizedBox(height: 20.0,),
        itemCount: tasks.length,
      );
    }
    else {
      return Center(child: Text(
        'No Habits Yet',
        style: TextStyle(
          fontSize: 50.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[300],
        ),
      ),);
    }
  }
}
