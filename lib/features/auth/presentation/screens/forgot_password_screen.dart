import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/component/text_field/common_text_field.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/core/utils/helper/other_helper.dart';
import 'package:stays_hotel_booking/features/auth/presentation/provider/forgot_password_provider.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(forgotPasswordLoadingProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
  child: LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [

                  const CommonText(
                    text: AppStrings.appName,
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),

                  const CommonText(
                    text: 'Forgot password?',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                    textAlign: TextAlign.center,
                  ),
                  const CommonText(
                    text: 'Enter your email below to reset your\npassword',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subTitle,
                    top: 8,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 44.h),

                  const CommonText(
                    text: 'Email',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),

                  SizedBox(
                    width: double.infinity,
                    child: CommonTextField(
                      controller: _emailCtrl,
                      hintText: AppStrings.signInEmailHint,
                      keyboardType: TextInputType.emailAddress,
                      validator: OtherHelper.emailValidator,
                      onChanged: (v) =>
                          ref.read(forgotPasswordEmailProvider.notifier).state = v,
                      borderColor: AppColors.black,
                      hintTextColor: AppColors.subTitle,
                      fillColor: AppColors.overlayBox,
                      borderRadius: 8,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  CommonButton(
                    titleText: loading ? 'Please wait...' : 'Verify',
                    buttonHeight: 46,
                    onTap: loading
    ? null
    : () async {
        if (!_formKey.currentState!.validate()) return;
        ref.read(forgotPasswordLoadingProvider.notifier).state = true;
        try {
          // call API here
          context.push(AppRoutes.forgotOtp);
        } finally {
          ref.read(forgotPasswordLoadingProvider.notifier).state = false;
        }
      },
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      );
    },
  ),
));
  }
}