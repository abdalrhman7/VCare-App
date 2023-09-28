import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/app_route/routes.dart';
import 'package:vcare_app/core/constants/text_style.dart';
import 'package:vcare_app/feature/home_screen/date/model/doctor_model.dart';

class DoctorSearchCard extends StatelessWidget {
  const DoctorSearchCard({
    super.key,
    required this.doctorModel,
  });
  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
          AppRoutes.detailsScreen,
          arguments: {'doctorDetails': doctorModel},
        );
      },
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.w)),
            width: 0.08.sh,
            height: 0.08.sh,
            child: FancyShimmerImage(
              width: double.infinity,
              errorWidget: const Icon(Icons.error),
              imageUrl: doctorModel.photo!,
              boxFit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 12.w),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(doctorModel.name! , style: Style.textStyle16.copyWith(fontWeight: FontWeight.w700)),
                Text(
                  doctorModel.degree!,
                  style: Style.textStyle12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
