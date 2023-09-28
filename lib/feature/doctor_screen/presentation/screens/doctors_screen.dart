import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/widgets/CustomCircularProgressIndicator.dart';
import 'package:vcare_app/feature/doctor_screen/business_logic/doctor_cubit/doctor_cubit.dart';

import '../widgets/doctors_grid_view.dart';
import '../widgets/filter_button.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  int? selectedCity;
  @override
  void initState() {
    BlocProvider.of<DoctorCubit>(context).getAllDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<DoctorCubit>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFilterButton(context, cubit, selectedCity),
          SizedBox(height: 12.h),
          BlocBuilder<DoctorCubit, DoctorState>(
            builder: (context, state) {
              if (state is GetAllDoctorSuccess) {
                return DoctorGridView(
                  doctor: state.doctors,
                );
              }
              if (state is GetFilterDoctorSuccess) {
                return DoctorGridView(
                  doctor: state.filterDoctors,
                );
              } else if (state is GetAllDoctorError) {
                return const Center(
                  child: Text('error'),
                );
              }
              return const CustomCircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
