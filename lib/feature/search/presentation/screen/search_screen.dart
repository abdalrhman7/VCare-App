import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/search_cubit/search_cubit.dart';
import '../widget/doctor_search_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SearchCubit>(context);
    return Padding(
      padding: EdgeInsets.all(18.r),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 6.h),
            TextField(
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                labelText: "Search for doctor",
                labelStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (text) {
                cubit.searchDoctor(text);
              },
              onSubmitted: (value) {
                cubit.searchDoctor(value);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchSuccess) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.doctors.length,
                    itemBuilder: (context, index) =>
                        DoctorSearchCard(doctorModel: state.doctors[index]),
                  );
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
