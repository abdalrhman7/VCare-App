import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/app_route/routes.dart';
import 'package:vcare_app/core/constants/app_color.dart';
import 'package:vcare_app/feature/home_screen/date/model/doctor_model.dart';

class DoctorGridView extends StatelessWidget {
  const DoctorGridView(
      {super.key, required this.doctor});
  final List<DoctorModel> doctor;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 6 / 7,
          crossAxisSpacing: 2,
          mainAxisSpacing: 4,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: doctor.length,
        itemBuilder: (ctx, index) {
          return buildDoctorItem(doctor[index]);
        },
      ),
    );
  }

  Widget buildDoctorItem(DoctorModel doctor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDoctorImage(doctor.photo!),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 5.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name!,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  doctor.description!,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          Builder(builder: (context) {
            return buildMoreDetailsTextButton(
                onPressed: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(AppRoutes.detailsScreen,
                        arguments: {'doctorDetails': doctor}));
          }),
        ],
      ),
    );
  }

  Widget buildDoctorImage(String photo) {
    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kMainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: FancyShimmerImage(
          width: double.infinity,
          errorWidget: const Icon(Icons.error),
          imageUrl: photo,
          boxFit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget buildMoreDetailsTextButton({VoidCallback? onPressed}) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Text('More Details'),
      label: const Icon(Icons.arrow_right_alt_rounded),
    );
  }
}
