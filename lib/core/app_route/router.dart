import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vcare_app/core/app_route/routes.dart';
import 'package:vcare_app/feature/account/data/account_repo/account_repo.dart';
import 'package:vcare_app/feature/details_screen/data/repo/store_appointment_repo.dart';
import 'package:vcare_app/feature/onboarding/View/Pages/onboarding.dart';
import 'package:vcare_app/injection.dart';
import '../../feature/account/business_logic/update_user_info_cubit/update_user_info_cubit.dart';
import '../../feature/account/presentation/screen/edit_account_screen.dart';
import '../../feature/auth/business_logic/register_cubit/register_cubit.dart';
import '../../feature/auth/date/repo/auth_repo.dart';
import '../../feature/auth/presentation/screens/login_screen.dart';
import '../../feature/auth/presentation/screens/register_screen.dart';
import '../../feature/bottom_navigation_bar/view/screen/bottom_navigation_bar.dart';
import '../../feature/details_screen/business_logic/store_appointment_cubit/store_appointment_cubit.dart';
import '../../feature/details_screen/presentation/view/details_screen.dart';
import '../../feature/splash_screen/splash_screen.dart';
import '../local_database/secure_storage.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.onBoardingScreen:
      return MaterialPageRoute(
        builder: (context) => const OnBoarding(),
        settings: settings,
      );

    case AppRoutes.loginScreen:
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
        settings: settings,
      );

    case AppRoutes.registerScreen:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) =>
              RegisterCubit(getIt.get<AuthRepo>(), getIt.get<SecureStorage>()),
          child: const RegisterScreen(),
        ),
        settings: settings,
      );

    case AppRoutes.bottomNavbar:
      return MaterialPageRoute(
        builder: (context) => const BottomNavbar(),
        settings: settings,
      );

    case AppRoutes.editAccountScreen:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => UpdateUserInfoCubit(
            getIt.get<AccountRepo>(),
            getIt.get<SecureStorage>(),
          ),
          child: const EditAccountScreen(),
        ),
        settings: settings,
      );

    case AppRoutes.detailsScreen:
      final args = settings.arguments as Map<String, dynamic>;
      final doctor = args['doctorDetails'];
      return MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<StoreAppointmentCubit>(
              create: (BuildContext context) => StoreAppointmentCubit(
                getIt.get<StoreAppointmentRepo>(),
                getIt.get<SecureStorage>(),
              ),
            ),
          ],
          child: DetailsScreen(doctor: doctor),
        ),
        settings: settings,
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );
  }
}
