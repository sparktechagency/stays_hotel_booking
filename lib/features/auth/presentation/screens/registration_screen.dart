import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/component/text_field/common_text_field.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_icons.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/core/utils/extensions/extension.dart';
import 'package:stays_hotel_booking/core/utils/helper/other_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stays_hotel_booking/features/auth/presentation/provider/registration_provider.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: AppColors.bg,
          elevation: 0,
             ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),

                // Logo
                const CommonText(
                  text: AppStrings.appName,
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: AppColors.base500,
                ),
                SizedBox(height: 14.h),

                // Title
                const CommonText(
                  text: AppStrings.registration,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                SizedBox(height: 8.h),

                // Subtitle
                const CommonText(
                  text: AppStrings.createYourAccount,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
                SizedBox(height: 40.h),

                // User Name Field
                const CommonText(
                  text: AppStrings.userName,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                SizedBox(height: 12.h),
                CommonTextField(
                  controller: _userNameController,
                  hintText: AppStrings.enterUserName,
                  validator: OtherHelper.validator,
                  borderColor: AppColors.black,
                  fillColor: AppColors.overlayBox,
                  borderRadius: 8,
                ),
                SizedBox(height: 20.h),

                // Email Field
                const CommonText(
                  text: AppStrings.email,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                SizedBox(height: 12.h),
                CommonTextField(
                  controller: _emailController,
                  hintText: AppStrings.enterEmail,
                  keyboardType: TextInputType.emailAddress,
                  validator: OtherHelper.emailValidator,
                  borderColor: AppColors.black,
                  fillColor: AppColors.overlayBox,
                  borderRadius: 8,
                ),

                   SizedBox(height: 20.h),

                const CommonText(
                  text: "Phone Number",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                SizedBox(height: 12.h),
                CommonTextField(
                  controller: _userNameController,
                  hintText: "Enter Phone Number",
                  validator: OtherHelper.validator,
                  borderColor: AppColors.black,
                  fillColor: AppColors.overlayBox,
                  borderRadius: 8,
                ),
                SizedBox(height: 20.h),


                // Password Field
                const CommonText(
                  text: AppStrings.password,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                SizedBox(height: 12.h),
                CommonTextField(
                  controller: _passwordController,
                  hintText: AppStrings.enterPassword,
                  isPassword: true,
                  obscure: ref.watch(registrationPasswordObscureProvider),
                  onToggleObscure: () {
                    final current = ref.read(registrationPasswordObscureProvider);
                    ref.read(registrationPasswordObscureProvider.notifier).state = !current;
                  },
                  validator: OtherHelper.passwordValidator,
                  borderColor: AppColors.black,
                  fillColor: AppColors.overlayBox,
                  borderRadius: 8,
                ),
                SizedBox(height: 40.h),

                // Sign Up Button
                CommonButton(
                  titleText: AppStrings.signUp,
                  buttonHeight: 50,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {

                      context.go(AppRoutes.home);
                    }
                  },
                ),
                SizedBox(height: 40.h),

                // Or separator
                Row(
                  children: [
                    Expanded(child: Divider(color: const Color(0xFFE2E2E2))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: CommonText(
                        text: AppStrings.or,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subTitle,
                      ),
                    ),
                    Expanded(child: Divider(color: const Color(0xFFE2E2E2))),
                  ],
                ),
                SizedBox(height: 24.h),

                // Social Login Buttons
                // Social buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      image: AppIcons.whiteApple,
                    ),
                  ),
                ],
              ),

                24.height,



                // Already have account
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText(
                        text: AppStrings.alreadyHaveAccount,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                      ),
                      SizedBox(width: 4.w),
                      GestureDetector(
                        onTap: () => context.push(AppRoutes.signIn),
                        child: CommonText(
                          text: AppStrings.signIn,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 80.h),
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
       // width: 75.w,
        decoration: BoxDecoration(
          color: AppColors.overlayBox,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 8,
              offset: const Offset(0, 10),
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
