import 'package:flutter/material.dart';
import 'package:vcare_app/core/app_route/routes.dart';
import 'package:vcare_app/feature/auth/presentation/view/screens/login_screen.dart';
import 'package:vcare_app/feature/onboarding/View/Pages/onboarding.dart';
import '../../feature/auth/presentation/view/screens/register_screen.dart';
import '../../feature/bottom_navigation_bar/view/screen/bottom_navigation_bar.dart';
import '../../feature/details_screen/presentation/view/details_screen.dart';
import '../../feature/splash_screen/splash_screen.dart';

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
        builder: (context) => const RegisterScreen(),
        settings: settings,
      );

      case AppRoutes.bottomNavbar:
      return MaterialPageRoute(
        builder: (context) => const BottomNavbar(),
        settings: settings,
      );

    case AppRoutes.detailsScreen:
      final args = settings.arguments as Map<String, dynamic>;
      final doctor = args['doctorDetails'];
      return MaterialPageRoute(
        builder: (context) =>  DetailsScreen(doctor:  doctor),
        settings: settings,
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );
  }
}
