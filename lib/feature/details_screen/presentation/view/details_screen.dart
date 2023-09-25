import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/constants/app_color.dart';
import 'package:vcare_app/core/constants/text_style.dart';
import 'package:vcare_app/feature/home_screen/date/model/home_model.dart';

import '../../../../core/widgets/main_button.dart';
import '../../../home_screen/date/model/doctor_model.dart';

class DetailsScreen extends StatelessWidget {
  final DoctorModel doctor;

  DetailsScreen({super.key, required this.doctor});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 0.3.sh,
              width: double.infinity,
              color: kMainColor,
              child: FancyShimmerImage(
                width: double.infinity,
                errorWidget: const Icon(Icons.error),
                imageUrl: doctor.photo!,
                boxFit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name!,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w400,
                      color: kMainColor,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    doctor.description!,
                    style: Style.textStyle18.copyWith(color: kMainColor),
                  ),
                  SizedBox(height: 10.h),
                  Divider(thickness: 1, color: Colors.grey.shade500),
                  SizedBox(height: 20.h),
                  _textInfo(text: 'Select date'),
                  SizedBox(height: 20.h),
                  buildShowTextFiled(context),
                  SizedBox(height: 20.h),
                  _textInfo(text: 'Select time'),
                  SizedBox(height: 20.h),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoseTimeWidget(),
                      ChoseTimeWidget(),
                      ChoseTimeWidget(),
                      ChoseTimeWidget(),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  MainButton(
                    text: 'Book an appointment',
                    onTap: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildShowTextFiled(BuildContext context) {
    return showTextFiled(
      context,
      () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2023),
          lastDate: DateTime(2030),
        );
        if (selectedDate != null) {
          final formattedDate =
              '${selectedDate.year.toString().substring(2)}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}';
          controller.text = formattedDate;
        }
      },
    );
  }

  Text _textInfo({required String text}) {
    return Text(
      text,
      style: Style.textStyle16
          .copyWith(color: kMainColor, fontWeight: FontWeight.w400),
    );
  }

  Widget showTextFiled(BuildContext context, VoidCallback onTap) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: controller.text.isEmpty ? 'yy/mm//dd' : controller.text,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 21,
          color: Color(0xff030E19),
        ),
      ),
    );
  }
}

class ChoseTimeWidget extends StatelessWidget {
  const ChoseTimeWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.r, vertical: 8.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22), color: kMainColor),
      child: Text(
        '9:00',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
