import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/app_route/routes.dart';
import 'package:vcare_app/feature/auth/business_logic/register_cubit/register_cubit.dart';
import 'package:vcare_app/feature/auth/date/repo/auth_repo.dart';

import 'core/app_route/router.dart';
import 'core/theme_data.dart';
import 'core/utilities/cache/cache_helpler.dart';
import 'core/utilities/cache/secure_storage.dart';
import 'feature/auth/business_logic/login_cubit/login_cubit.dart';
import 'injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.cacheInitialization();
  initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            create: (_) => LoginCubit(getIt.get<AuthRepo>() , getIt.get<SecureStorage>()),
          ),
          BlocProvider<RegisterCubit>(
            create: (_) => RegisterCubit(getIt.get<AuthRepo>()),
          ),
        ],
        child: MaterialApp(
          title: 'V Care App',
          debugShowCheckedModeBanner: false,
          theme: themeData(context),
          //initialRoute: AppRoutes.bottomNavbar,
          onGenerateRoute: generateRoute,
        ),
      ),
    );
  }
}
