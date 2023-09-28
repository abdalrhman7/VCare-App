import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/app_route/routes.dart';

import '../../../../core/constants/text_style.dart';
import '../../../../core/widgets/CustomCircularProgressIndicator.dart';
import '../../business_logic/user_info_cubit/user_info_cubit.dart';

class UserInfoBlocBuilder extends StatelessWidget {
  const UserInfoBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      builder: (context, state) {
        if (state is UserInfoSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: ImageIcon(
                  size: 34,
                  AssetImage('assets/Icons/user.png'),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(
                  state.userModel.name!,
                  style: Style.textStyle20
                      .copyWith(overflow: TextOverflow.visible),
                ),
              ),
              buildEditAccountDetailsButton(context),
              const Divider(color: Colors.black),
              SizedBox(height: 20.h),
              Row(
                children: [
                  const Icon(Icons.email_outlined),
                  SizedBox(width: 10.w),
                  Text(state.userModel.email!, style: Style.textStyle18)
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  const Icon(Icons.phone),
                  SizedBox(width: 10.w),
                  Text(state.userModel.phone!, style: Style.textStyle18),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  const Icon(Icons.lock_outline),
                  SizedBox(width: 10.w),
                  Text('ºººººººººº', style: Style.textStyle18),
                ],
              ),
            ],
          );
        } else if (state is UserInfoLoading) {
          return const CustomCircularProgressIndicator();
        }
        return const Center(child: Text('error'));
      },
    );
  }

  Widget buildEditAccountDetailsButton(BuildContext context) {
    return Center(
      child: TextButton.icon(
        label: const Icon(
          Icons.edit,
          color: Colors.grey,
        ),
        icon: Text('Edit Account Details',
            style: Style.textStyle18.copyWith(color: Colors.grey)),
        onPressed: () => Navigator.of(context, rootNavigator: true)
            .pushNamed(AppRoutes.editAccountScreen),
      ),
    );
  }
}
