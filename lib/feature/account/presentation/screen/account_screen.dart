import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/widgets/main_button.dart';

import '../../../../core/app_route/routes.dart';
import '../../../auth/business_logic/login_cubit/login_cubit.dart';
import '../../business_logic/user_info_cubit/user_info_cubit.dart';
import '../widget/user_info_bloc_builder.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    BlocProvider.of<UserInfoCubit>(context).getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserInfoBlocBuilder(),
          const Spacer(),
          MainButton(
            text: 'Logout',
            onTap: () {
              BlocProvider.of<LoginCubit>(context).logout();
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil(
                      AppRoutes.loginScreen, (route) => false);
            },
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
