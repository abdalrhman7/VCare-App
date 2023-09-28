import 'package:flutter/material.dart';

class BuildRegisterOrLoginHereButton extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onPressed;
  const BuildRegisterOrLoginHereButton({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text),
        TextButton(
          onPressed: onPressed,
          child: Text(buttonText),
        )
      ],
    );
  }
}