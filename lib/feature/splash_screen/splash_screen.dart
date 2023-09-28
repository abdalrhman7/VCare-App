import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vcare_app/core/app_route/routes.dart';
import 'package:vcare_app/core/constants/app_color.dart';
import 'package:vcare_app/core/constants/text_style.dart';

import '../../core/local_database/cache_helpler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 2), () {
      navigateUser();
    });
  }

  void navigateUser() async {
    if (CacheData.getData(key: 'OnBoarding') == null) {
      CacheData.setData(key: 'OnBoarding', value: false);
    }
    if (CacheData.getData(key: 'OnBoarding') == false) {
      Navigator.pushReplacementNamed(context, AppRoutes.onBoardingScreen);
    } else {
      FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
      flutterSecureStorage.read(key: 'token').then((value) {
        if (value != null) {
          Navigator.pushReplacementNamed(context, AppRoutes.bottomNavbar);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: kMainColor,
        child: Center(
          child: Text(
            'VCare',
            style: Style.textStyle32.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
