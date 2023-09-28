import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/constants/app_color.dart';
import 'package:vcare_app/feature/history_screen/data/model/appointment_model.dart';

import 'appoiintmet_details_dialog.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointmentModel,
  });
  final AppointmentModel appointmentModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         appointmentDetailsDialog(context: context , appointmentModel: appointmentModel );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kMainColor)),
        child: Row(
          children: [
            SizedBox(
              width: 100.w,
              height: 80.h,
              child: FancyShimmerImage(
                width: double.infinity,
                errorWidget: const Icon(Icons.error),
                imageUrl: appointmentModel.doctor!.photo ?? '',
                boxFit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 6.w),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('name : ${appointmentModel.doctor!.name} '),
                  SizedBox(height: 5.h),
                  Text(
                    'date : ${appointmentModel.appointmentTime} ',
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text('price : ${appointmentModel.appointmentPrice} '),
                  SizedBox(height: 5.h),
                  Text('status : ${appointmentModel.status} '),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
