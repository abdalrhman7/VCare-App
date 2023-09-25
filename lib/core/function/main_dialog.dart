import 'package:flutter/material.dart';

import '../constants/text_style.dart';

class MainDialog {
  final BuildContext context;
  final String title;
  final String content;
  final List<Map<String, void Function()?>>? actions;

  MainDialog({
    required this.context,
    required this.title,
    required this.content,
    this.actions,
  });

  showAlertDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            title,
            style: Style.textStyle16,
          ),
          content: Text(
            content,
            style: Style.textStyle16,
          ),
          actions: (actions != null)
              ? actions!
              .map((action) => TextButton(
            onPressed: action.values.first,
            child:  Text(action.keys.first),
          ))
              .toList()
              : [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ));
  }
}