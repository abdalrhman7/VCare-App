import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle appStyle({required double size}) {
  return TextStyle(
    fontSize: size.sp,
    fontWeight: FontWeight.normal,
    overflow: TextOverflow.ellipsis,
  );
}

class Style {
  static final textStyle8 = appStyle(size: 8);

  static final textStyle10 = appStyle(size: 10);

  static final textStyle11 = appStyle(size: 11);

  static final textStyle12 = appStyle(size: 12);

  static final textStyle14 = appStyle(size: 14);

  static final textStyle15 = appStyle(size: 15);

  static final textStyle16 = appStyle(size: 16);

  static final textStyle18 = appStyle(size: 18);

  static final textStyle20 = appStyle(size: 20);

  static final textStyle22 = appStyle(size: 22);

  static final textStyle24 = appStyle(size: 24);

  static final textStyle26 = appStyle(size: 26);

  static final textStyle28 = appStyle(size: 28);

  static final textStyle30 = appStyle(size: 30);

  static final textStyle32 = appStyle(size: 32);

  static final textStyle34 = appStyle(size: 34);

  static final textStyle60 = appStyle(size: 60);
}
