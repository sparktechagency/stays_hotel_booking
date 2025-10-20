import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/extensions/extension.dart';

class SignInOrRegisterScreen extends StatelessWidget {
  const SignInOrRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.signInOrRegister,
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
        Positioned(
           bottom: 50,
           left: 0,
           right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.w, 20, 20.w, 24.h),
              margin: EdgeInsets.only(bottom: 16.h),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(32.w, 20.h, 32.w, 20.h),
                    decoration: BoxDecoration(
                      color: const Color(0x33FCFCFD),
                      borderRadius: BorderRadius.circular(32.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.01),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CommonText(
                          text: 'STAYS.',
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          color: AppColors.base500,
                        ),
                        const CommonText(
                          text:
                              'Life is short and the world is wide.\nLogin or register now!',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          top: 12,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 44.h),
                        CommonButton(
                          titleText: 'Login',
                          buttonHeight: 46,
                            buttonRadius: 8,
                            onTap: () => context.push(AppRoutes.signIn),
                        ),
                        SizedBox(height: 20.h),
                       
                       
                        SizedBox(
                          height: 46.h,
                          width: double.infinity,
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8.r),
                              onTap: () => context.push(AppRoutes.registration),
                              child: Ink(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.base50,
                                  ),
                                  color: AppColors.base50,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: CommonText(
                                    text: 'Register',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.base500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        20.height,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
       
       40.height
       
        ],
      ),
    );
  }
}
