import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/constants/app_color.dart';
import 'package:vcare_app/core/constants/text_style.dart';
import 'package:vcare_app/feature/details_screen/business_logic/store_appointment_cubit/store_appointment_cubit.dart';

import '../../../../core/function/main_snack_bar.dart';
import '../../../../core/widgets/CustomCircularProgressIndicator.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../home_screen/date/model/doctor_model.dart';
import '../../data/model/appointment_model.dart';
import '../widget/date_text_field.dart';
import '../widget/doctor_photo.dart';
import '../widget/time_text_field.dart';

class DetailsScreen extends StatelessWidget {
  final DoctorModel doctor;

  DetailsScreen({super.key, required this.doctor});
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<StoreAppointmentCubit>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DoctorPhoto(doctor: doctor),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.r),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor.name!, style: Style.textStyle32),
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
                    DateTextField(dateController: dateController),
                    SizedBox(height: 20.h),
                    _textInfo(text: 'Select time'),
                    SizedBox(height: 20.h),
                    TimeTextField(timeController: timeController),
                    SizedBox(height: 20.h),
                    SizedBox(height: 20.h),
                    buildBlocConsumerMainButton(cubit, doctor),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _textInfo({required String text}) {
    return Text(
      text,
      style: Style.textStyle16
          .copyWith(color: kMainColor, fontWeight: FontWeight.w400),
    );
  }

  Widget buildBlocConsumerMainButton(
      StoreAppointmentCubit cubit, DoctorModel doctor) {
    return BlocConsumer<StoreAppointmentCubit, StoreAppointmentState>(
      listener: (context, state) {
        if (state is StoreAppointmentSuccess) {
          mainSnackBar(context, 'Store Appointment Success');
        }
        if (state is StoreAppointmentError) {
          mainSnackBar(context, 'Try again later');
        }
      },
      builder: (context, state) {
        if (state is StoreAppointmentLoading) {
          return const CustomCircularProgressIndicator();
        }
        return MainButton(
          text: 'Book an appointment',
          onTap: () {
            validateAndSubmit(cubit, doctor);
          },
        );
      },
    );
  }

  void validateAndSubmit(StoreAppointmentCubit cubit, DoctorModel doctor) {
    if (_formKey.currentState!.validate()) {
      StoreAppointmentModel storeAppointment = StoreAppointmentModel(
          doctorId: doctor.id!,
          startTime: '${dateController.text} ${timeController.text}');
      cubit.storeAppointment(storeAppointment);
    }
  }
}
