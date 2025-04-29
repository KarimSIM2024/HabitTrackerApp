import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'generator_cat.dart';

class BuildCategory extends StatelessWidget {
  final String title;
  final List tasks;
  final Color color;
  const BuildCategory({super.key, required this.title, required this.tasks, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: color),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(child: GeneratorCat(tasks: tasks,))
            ],
          ),
        ),
      ),
    );
  }
}
