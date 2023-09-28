import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/feature/doctor_screen/presentation/widgets/drop_down.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/local_database/secure_storage.dart';
import '../../../../core/widgets/CustomCircularProgressIndicator.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../injection.dart';
import '../../business_logic/doctor_cubit/doctor_cubit.dart';
import '../../business_logic/get_all_city/get_all_city_cubit.dart';
import '../../date/doctor_repo/doctor_repo.dart';

Widget buildFilterButton(
    BuildContext context, DoctorCubit cubit, int? selectedCity) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        constraints: BoxConstraints(maxHeight: 0.45.sh),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xff757575),
            child: Container(
              padding: EdgeInsets.all(20.r),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildFilterText(cubit ),
                  SizedBox(height: 16.h),
                  buildCityRow(),
                  SizedBox(height: 16.h),
                  BlocProvider(
                    create: (context) => GetAllCityCubit(
                        getIt.get<DoctorRepo>(), getIt<SecureStorage>())
                      ..getAllCities(),
                    child: BlocBuilder<GetAllCityCubit, GetAllCityState>(
                      builder: (context, state) {
                        if (state is GetAllCityLoading) {
                          return const CustomCircularProgressIndicator();
                        }
                        if (state is GetAllCitySuccess) {
                          return DropDownMenuComponent(
                            hint: 'Filter By City',
                            cities: state.cities,
                            onChanged: (value) {
                              selectedCity = int.parse(value!);
                              print(selectedCity);
                            },
                          );
                        }
                        return const Text('Error');
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  buildFilterNameRow('GOVERNORATE'),
                  SizedBox(height: 16.h),
                  buildFilterNameRow('SPECIALIZATION'),
                  SizedBox(height: 16.h),
                  MainButton(
                    text: 'APPLY',
                    onTap: () {
                      if (selectedCity != null) {
                        cubit.getFilterDoctor(cityId: selectedCity!);
                      }
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        },
      );
    },
    child: buildFilterContainer(),
  );
}

Container buildFilterContainer() {
  return Container(
    height: 40.h,
    width: 120.w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), color: kMainColor),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.filter_alt_outlined, color: Color(0xffF3FAF9)),
        Text(
          'Filter',
          style: TextStyle(
            color: const Color(0xffF3FAF9),
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    ),
  );
}

Widget buildFilterNameRow(String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        name,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      const Icon(Icons.add)
    ],
  );
}

Widget buildCityRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'City',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      const Spacer(),
      Text(
        'clear',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      SizedBox(width: 8.w),
      const ImageIcon(
        AssetImage('assets/Icons/minus.png'),
      ),
    ],
  );
}

Widget buildFilterText(DoctorCubit cubit) {
  return Row(
    children: [
      const Icon(Icons.filter_alt_outlined, color: kMainColor),
      Text(
        'Filter',
        style: TextStyle(
          color: kMainColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      const Spacer(),
      if (cubit.isFilter)
        SizedBox(
          height: 34.h,
          child: Builder(
            builder: (context) {
              return TextButton(
                onPressed: () {
                  cubit.cancelFilter();
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel Filter'),
              );
            }
          ),
        ),
    ],
  );
}
