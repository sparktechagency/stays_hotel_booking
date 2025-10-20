import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/component/text_field/common_text_field.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/core/utils/helper/other_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stays_hotel_booking/features/auth/presentation/provider/sign_in_provider.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool rememberMe = false;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        // leading: InkWell(
        //   onTap: () => context.pop(),
        //   child: Icon(
        //     size: 24.sp,
        //     Icons.arrow_back_ios_new, color: AppColors.black),
        // ),

        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.black,
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: AppStrings.signInTitle, // "Sign in to your\nAccount."
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                  bottom: 8,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
                const CommonText(
                  text: AppStrings
                      .signInSubtitle, // "Enter your email and password to log in"
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subTitle,
                  bottom: 40,
                  textAlign: TextAlign.left,
                ),

                // Email
                const CommonText(
                  text: AppStrings.signInEmailLabel, // "Email"
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  bottom: 12,
                  textAlign: TextAlign.left,
                ),
                CommonTextField(
                  controller: emailCtrl,
                  hintText: AppStrings.signInEmailHint, // "Enter  Email"
                  borderColor: AppColors.filledColor,
                  fillColor: AppColors.white,
                  borderRadius: 8,
                  validator: OtherHelper.emailValidator,

                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20.h),

                // Password
                const CommonText(
                  text: AppStrings.signInPasswordLabel, // "Password"
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  bottom: 8,
                  textAlign: TextAlign.left,
                ),
                CommonTextField(
                  controller: passwordCtrl,
                  hintText: AppStrings.signInPasswordHint, // "Enter Password"
                  isPassword: true,
                  validator: OtherHelper.passwordValidator,
                  borderColor: AppColors.filledColor,
                  fillColor: AppColors.white,
                  borderRadius: 8,
                  textInputAction: TextInputAction.done,
                  obscure: ref.watch(signInPasswordObscureProvider),
                  onToggleObscure: () {
                    final current = ref.read(signInPasswordObscureProvider);
                    ref.read(signInPasswordObscureProvider.notifier).state =
                        !current;
                  },
                ),

                SizedBox(height: 21.h),

                // Remember me + Forgot password
                Row(
                  children: [
                    SizedBox(
                      width: 15.w,
                      height: 15.h,
                      child: Checkbox(
                        value: ref.watch(signInRememberMeProvider),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        side: BorderSide(color: AppColors.text, width: 1),
                        activeColor: AppColors.base500,
                        onChanged: (v) =>
                            ref.read(signInRememberMeProvider.notifier).state =
                                v ?? false,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),

                    const CommonText(
                      left: 10,
                      text: AppStrings.signInRememberMe,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.text,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.forgotPassword);
                      }, // TODO: navigate to forgot password
                      child: const CommonText(
                        text: AppStrings.signInForgotPassword,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.yellow,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                // Login CTA
                CommonButton(
                  titleText: AppStrings.signInLogin,
                  buttonHeight: 50,
                  onTap: () {
                    if (!formKey.currentState!.validate()) return;
                    context.go(AppRoutes.home);
                  },
                ),

                SizedBox(height: 40.h),

                // Divider with "or"
                Row(
                  children: [
                    Expanded(child: Divider(color: Color(0xFFE2E2E2))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: const CommonText(
                        text: AppStrings.signInOr,
                        fontSize: 14,
                        left: 10,
                        right: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subTitle,
                      ),
                    ),
                    Expanded(child: Divider(color: Color(0xFFE2E2E2))),
                  ],
                ),

                SizedBox(height: 40.h),

                // Social buttons
                Row(
                  children: [
                    Expanded(
                      child: _SocialButton(
                        onTap: () {},
                        image: AppImages.google,
                      ),
                    ),
                    SizedBox(width: 28.w),
                    Expanded(
                      child: _SocialButton(
                        onTap: () {},
                        image: AppImages.apple,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                // Sign up text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    CommonText(
                      text: AppStrings.signInNoAccount,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.text,
                    ),
                    SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        context.push(AppRoutes.registration);
                      },
                      child: CommonText(
                        text: AppStrings.signInSignUp,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.image, required this.onTap});
  final String image;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: CommonImage(imageSrc: image, height: 24.h, width: 24.w),
        ),
      ),
    );
  }
}
