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
import 'package:stays_hotel_booking/features/auth/presentation/providers/change_password_provider.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(changePasswordNotifierProvider);

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              
              // Header
              _buildHeader(),
              
              SizedBox(height: 32.h),
              
              // Password fields
              _buildPasswordFields(state),
              
              const Spacer(),
              
              // Save button
              _buildSaveButton(state),
              
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.text,
            size: 20,
          ),
        ),
        SizedBox(width: 16.w),
        const Expanded(
          child: CommonText(
            text: AppStrings.changePassword,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordFields(ChangePasswordState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Current Password Field
        _buildPasswordField(
          label: AppStrings.changePassword,
          controller: _currentPasswordController,
          hintText: AppStrings.currentPassword,
          isObscured: !state.isCurrentPasswordVisible,
          onToggleVisibility: () {
            ref.read(changePasswordNotifierProvider.notifier).toggleCurrentPasswordVisibility();
          },
          onChanged: (value) {
            ref.read(changePasswordNotifierProvider.notifier).updateCurrentPassword(value);
            if (state.error != null) {
              ref.read(changePasswordNotifierProvider.notifier).clearError();
            }
          },
        ),
        
        SizedBox(height: 24.h),
        
        // New Password Field
        _buildPasswordField(
          label: AppStrings.newPassword,
          controller: _newPasswordController,
          hintText: AppStrings.newPassword,
          isObscured: !state.isNewPasswordVisible,
          onToggleVisibility: () {
            ref.read(changePasswordNotifierProvider.notifier).toggleNewPasswordVisibility();
          },
          onChanged: (value) {
            ref.read(changePasswordNotifierProvider.notifier).updateNewPassword(value);
            if (state.error != null) {
              ref.read(changePasswordNotifierProvider.notifier).clearError();
            }
          },
        ),
        
        SizedBox(height: 24.h),
        
        // Confirm Password Field
        _buildPasswordField(
          label: AppStrings.confirmPassword,
          controller: _confirmPasswordController,
          hintText: AppStrings.currentPassword, // Note: This matches the screenshot placeholder
          isObscured: !state.isConfirmPasswordVisible,
          onToggleVisibility: () {
            ref.read(changePasswordNotifierProvider.notifier).toggleConfirmPasswordVisibility();
          },
          onChanged: (value) {
            ref.read(changePasswordNotifierProvider.notifier).updateConfirmPassword(value);
            if (state.error != null) {
              ref.read(changePasswordNotifierProvider.notifier).clearError();
            }
          },
        ),
        
     
        
     ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required bool isObscured,
    required VoidCallback onToggleVisibility,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        CommonText(
          text: label,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.text,
        ),
        SizedBox(height: 8.h),
        
        // Password field
        CommonTextField(
          controller: controller,
          hintText: hintText,
          isPassword: true,
          obscure: isObscured,
          onToggleObscure: onToggleVisibility,
          onChanged: onChanged,
          borderColor: AppColors.black,
          hintTextColor: AppColors.subTitle,
          fillColor: AppColors.overlayBox,
          borderRadius: 8,
        ),
      ],
    );
  }

  Widget _buildSaveButton(ChangePasswordState state) {
    return CommonButton(
      titleText: AppStrings.save,
      buttonHeight: 50,
      isLoading: state.isLoading,
      onTap: () {
        //context.go(AppRoutes.signIn);
      ref.read(changePasswordNotifierProvider.notifier).changePassword();
      },
    );
  }
}
