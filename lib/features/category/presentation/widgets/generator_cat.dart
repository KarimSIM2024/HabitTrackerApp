import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../../../features/category/presentation/widgets/build_item_cat.dart';

class GeneratorCat extends StatelessWidget {
  final List tasks;

  const GeneratorCat({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder:
          (context) => ListView.builder(
            itemBuilder: (context, index) => BuildItemCat(model: tasks[index]),
            itemCount: tasks.length,
          ),
      fallback:
          (context) => Center(
            child: Text(
              'No Habits Yet',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[300],
              ),
            ),
          ),
    );
  }
}
