import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color buttonColor;

  const MyButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
