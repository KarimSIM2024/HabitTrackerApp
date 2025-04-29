import 'package:flutter/material.dart';
import 'build_item_home.dart';


class GeneratorHome extends StatelessWidget {
  final List tasks;
  const GeneratorHome({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
      return ListView.separated(
        itemBuilder: (context, index) => BuildItemHome(model: tasks[index],),
        separatorBuilder: (context, index) => SizedBox(height: 20.0,),
        itemCount: tasks.length,
      );
  }
}
