import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/constants/app_color.dart';
import 'package:vcare_app/core/constants/text_style.dart';
import 'package:vcare_app/core/widgets/CustomCircularProgressIndicator.dart';
import 'package:vcare_app/feature/home_screen/business_logic/home_cubit/home_cubit.dart';

import '../../../../../core/app_route/routes.dart';
import '../../../date/model/doctor_model.dart';
import '../../../date/model/home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).getHomeDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
      return  BlocProvider.of<HomeCubit>(context).getHomeDoctors();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.r),
        child: Column(
          children: [
            buildBlocBuilder(),
          ],
        ),
      ),
    );
  }

  Widget buildBlocBuilder() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          return buildSpecializationListView(state.homeModel);
        }
        if (state is HomeError) {
          return Center(child: Text(state.errMessage));
        }
        return const CustomCircularProgressIndicator();
      },
    );
  }

  Widget buildSpecializationListView(List<HomeModel> homeModel) {
    return Expanded(
      child: ListView.builder(
        itemCount: homeModel.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    homeModel[index].name!,
                    style: Style.textStyle20,
                  ),
                  buildMoreDetailsTextButton(onPressed: () {}),
                ],
              ),
              buildDoctorItemsListView(homeModel),
            ],
          );
        },
      ),
    );
  }

  Widget buildDoctorItemsListView(List<HomeModel> homeModel) {
    return SizedBox(
      height: 200.h,
      width: double.infinity,
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        scrollDirection: Axis.horizontal,
        itemCount: homeModel.length - 2,
        itemBuilder: (context, index) {
          return buildDoctorItem(
              homeModel[index], homeModel[index].doctors![index]);
        },
      ),
    );
  }

  Widget buildDoctorItem(HomeModel homeModel, DoctorModel doctors) {
    return Container(
      height: 210.h,
      width: 145.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDoctorImage(doctors.photo!),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 5.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctors.name!,
                  style:
                      Style.textStyle16.copyWith(fontWeight: FontWeight.w400),
                ),
                Text(
                  doctors.description!,
                  style: Style.textStyle12.copyWith(color: kGreyTextColor),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(3.r),
            child: buildMoreDetailsTextButton(
                onPressed: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(AppRoutes.detailsScreen,
                        arguments: {'doctorDetails': doctors})),
          ),
        ],
      ),
    );
  }

  Widget buildDoctorImage(String photo) {
    return Container(
      height: 100.h,
      width: 145.w,
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
