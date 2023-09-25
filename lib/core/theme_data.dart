import 'package:flutter/material.dart';
import 'package:vcare_app/core/constants/app_color.dart';

import 'constants/text_style.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    appBarTheme: const AppBarTheme(color: kMainColor),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: Theme.of(context).textTheme.titleMedium,
      focusedBorder: const OutlineInputBorder(
        // borderRadius: BorderRadius.circular(2.0),
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        //borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        // borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        // borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        //borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
    ),
  );
}
