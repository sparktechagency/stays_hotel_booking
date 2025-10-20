import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/onboarding_bg.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF18191B).withOpacity(0.0),
                  const Color(0xFF18191B).withOpacity(0.9),
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  const CommonText(
                    text: AppStrings.appName,
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                  const CommonText(
                    text: AppStrings.onboardingSubtitle,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white500,
                    top: 10,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 84.h),

                  CommonButton(
                    titleText: AppStrings.onboardingCta,
                    buttonHeight: 50,
                    onTap: () => context.push(AppRoutes.subscription),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}