import 'package:flutter/material.dart';

class MyTxtButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final bool isUpperCase;
  final TextStyle? style;

  const MyTxtButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.style,
    this.isUpperCase = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: style,
      ),
    );
  }
}
