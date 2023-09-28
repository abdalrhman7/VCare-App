import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/constants/text_style.dart';

import '../../../../core/constants/app_color.dart';
import '../../data/model/appointment_model.dart';

Future appointmentDetailsDialog({
  required BuildContext context,
  required AppointmentModel appointmentModel,
}) {
  return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Sign In',
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 0.75.sh,
            width: 0.8.sh,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
            child:  Scaffold(body: AppointmentDetails(appointmentModel: appointmentModel)),
          ),
        );
      });
}

class AppointmentDetails extends StatelessWidget {
  const AppointmentDetails({super.key, required this.appointmentModel});
  final AppointmentModel appointmentModel;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle14 =
        Style.textStyle14.copyWith(fontWeight: FontWeight.w500);
    final TextStyle textStyle20 =
        Style.textStyle20.copyWith(fontWeight: FontWeight.bold);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Doctor details', style: textStyle20),
            SizedBox(height: 6.h),
            Text('name : ${appointmentModel.doctor!.name}', style: textStyle14),
            SizedBox(height: 2.h),
            Text('location : ${appointmentModel.doctor!.address}', style: textStyle14),
            SizedBox(height: 2.h),
            Text('email : ${appointmentModel.doctor!.email}', style: textStyle14),
            SizedBox(height: 2.h),
            Text('phone : ${appointmentModel.doctor!.phone}}', style: textStyle14),
            SizedBox(height: 6.h),
            Text('Patient details ', style: textStyle20),
            SizedBox(height: 6.h),
            Text('name : ${appointmentModel.patient!.name}', style: textStyle14),
            SizedBox(height: 2.h),
            Text('gender : ${appointmentModel.patient!.gender}', style: textStyle14),
            SizedBox(height: 2.h),
            Text('email : ${appointmentModel.patient!.email}', style: textStyle14),
            SizedBox(height: 2.h),
            Text('phone : ${appointmentModel.patient!.phone} ', style: textStyle14),
            SizedBox(height: 6.h),
            Text('Appointment details', style: textStyle20),
            SizedBox(height: 6.h),
            Text('date : ${appointmentModel.appointmentTime} ', style: textStyle14),
            SizedBox(height: 2.h),
            Text('appointment id : ${appointmentModel.doctor!.id} ', style: textStyle14),
            SizedBox(height: 2.h),
            Text('status : ${appointmentModel.status}', style: textStyle14),
            SizedBox(height: 16.h),
            Container(
              decoration: BoxDecoration(
                  color: kMainColor, borderRadius: BorderRadius.circular(12.w)),
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Row(children: [
                  Text('Total',
                      style: textStyle14.copyWith(color: Colors.white)),
                  const Spacer(),
                  Text('${appointmentModel.appointmentPrice}', style: textStyle14.copyWith(color: Colors.white)),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
