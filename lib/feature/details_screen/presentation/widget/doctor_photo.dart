import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_color.dart';
import '../../../home_screen/date/model/doctor_model.dart';

class DoctorPhoto extends StatelessWidget {
  const DoctorPhoto({
    super.key,
    required this.doctor,
  });

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.3.sh,
      width: double.infinity,
      color: kMainColor,
      child: FancyShimmerImage(
        width: double.infinity,
        errorWidget: const Icon(Icons.error),
        imageUrl: doctor.photo!,
        boxFit: BoxFit.fill,
      ),
    );
  }
}