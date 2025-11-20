import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/component/text_field/common_text_field.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/core/utils/helper/other_helper.dart';
import 'package:stays_hotel_booking/features/auth/presentation/provider/create_new_password_provider.dart';

class CreateNewPasswordScreen extends ConsumerStatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  ConsumerState<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends ConsumerState<CreateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(createNewPasswordLoadingProvider);
    final newObscure = ref.watch(newPasswordObscureProvider);
    final confirmObscure = ref.watch(confirmPasswordObscureProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.bg,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: ConstrainedBox(
                                            constraints: BoxConstraints(minHeight: constraints.maxHeight),

                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                                
                        const CommonText(
                          text: AppStrings.appName,
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          color: AppColors.base500,
                        ),
                        SizedBox(height: 16.h),
                                
                        const CommonText(
                          text: 'Create New Password',
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.text,
                        ),
                        const CommonText(
                          text: 'Your new password must be different from previous\npasswords.',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subTitle,
                          top: 12,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                        ),
                                
                        SizedBox(height: 44.h),
                                
                        const CommonText(
                          text: 'New Password',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.text,
                        ),
                        SizedBox(height: 12.h),
                                
                        CommonTextField(
                          controller: _newCtrl,
                          hintText: 'Enter New Password',
                          isPassword: true,
                          obscure: newObscure,
                          onToggleObscure: () {
                            final current = ref.read(newPasswordObscureProvider);
                            ref.read(newPasswordObscureProvider.notifier).state = !current;
                          },
                          validator: OtherHelper.passwordValidator,
                          borderColor: AppColors.black,
                          hintTextColor: AppColors.subTitle,
                          fillColor: AppColors.overlayBox,
                          borderRadius: 8,
                          textInputAction: TextInputAction.next,
                        ),
                                
                        SizedBox(height: 12.h),
                                
                        const CommonText(
                          text: 'Confirm Password',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.text,
                        ),
                        SizedBox(height: 12.h),
                                
                        CommonTextField(
                          controller: _confirmCtrl,
                          hintText: 'Enter Confirm Password',
                          isPassword: true,
                          obscure: confirmObscure,
                          onToggleObscure: () {
                            final current = ref.read(confirmPasswordObscureProvider);
                            ref.read(confirmPasswordObscureProvider.notifier).state = !current;
                          },
                          validator: (v) {
                            final base = OtherHelper.passwordValidator(v);
                            if (base != null) return base;
                            if (v != _newCtrl.text) return 'The password does not match';
                            return null;
                          },
                          borderColor: AppColors.black,
                          hintTextColor: AppColors.subTitle,
                          fillColor: AppColors.overlayBox,
                          borderRadius: 8,
                          textInputAction: TextInputAction.done,
                        ),
                                
                        SizedBox(height: 44.h),
                                
                        CommonButton(
                          titleText: isLoading ? 'Please wait...' : 'Save',
                          buttonHeight: 50,
                          onTap: isLoading
                              ? null
                              : () async {
                                  if (!_formKey.currentState!.validate()) return;
                                  ref.read(createNewPasswordLoadingProvider.notifier).state = true;
                                  try {
                                    // TODO: Submit new password to backend
                                    // After success, navigate as needed (e.g., back to Sign In)
                                   // context.go(AppRoutes.signIn); // or push replacement to Sign In
                                  } finally {
                                    ref.read(createNewPasswordLoadingProvider.notifier).state = false;
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
          }
        ),
      ),
    );
  }
}