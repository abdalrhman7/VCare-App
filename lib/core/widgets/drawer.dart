import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../feature/auth/business_logic/login_cubit/login_cubit.dart';
import '../app_route/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 42.h),
          GestureDetector(
            onTap: () {
              BlocProvider.of<LoginCubit>(context).logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.loginScreen, (route) => false);
            },
            child: const ListTile(
              title: Text(
                'log out',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
