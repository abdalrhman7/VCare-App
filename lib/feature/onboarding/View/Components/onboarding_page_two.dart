import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

import '../../../../core/constants/app_color.dart';

PageModel onBoardingPageTwo() {
  return PageModel(
    widget: DecoratedBox(
      decoration: BoxDecoration(
        color: kMainColor,
        border: Border.all(
          width: 0.0,
          color: kMainColor,
        ),
      ),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45.0,
                vertical: 90.0,
              ),
              child: Image.asset(
                'assets/images/SecondOnboardingImage.png',
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0),
              child: Text(
                'Book Appointment',
                style: pageTitleStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
              child: Text(
                'Book on appointment with \n a right doctor ',
                style: pageInfoStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
