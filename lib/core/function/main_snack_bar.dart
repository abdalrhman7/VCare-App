import 'package:flutter/material.dart';

import '../constants/app_color.dart';

void mainSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    backgroundColor: kMainColor,
    content: Text(title),
    duration: const Duration(milliseconds: 1000),
  ));
}
