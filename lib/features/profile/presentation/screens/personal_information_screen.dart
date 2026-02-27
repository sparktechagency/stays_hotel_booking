import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/component/text_field/common_text_field.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/features/profile/presentation/providers/personal_info_provider.dart';

class PersonalInformationScreen extends ConsumerStatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  ConsumerState<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends ConsumerState<PersonalInformationScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = ref.read(personalInfoNotifierProvider);
    _fullNameController.text = state.fullName;
    _emailController.text = state.email;
    _addressController.text = state.address;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(personalInfoNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              
              // Header with back button and title
              _buildHeader(),
              
              SizedBox(height: 24.h),
              
              // Profile Summary Card
              _buildProfileSummaryCard(state),
              
              SizedBox(height: 24.h),
              
              // About Section
              _buildAboutSection(state),
              
              SizedBox(height: 24.h),
              
              // Form Fields
              _buildFormFields(state),
              
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
            color: AppColors.black,
            size: 20,
          ),
        ),
        SizedBox(width: 16.w),
        const Expanded(
          child: CommonText(
            text: AppStrings.personalInformation,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSummaryCard(PersonalInfoState state) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Image
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: CommonImage(
              imageSrc: AppImages.profile,
              width: 80.w,
              height: 80.h,
              fill: BoxFit.cover,
            ),
          ),
          
          SizedBox(width: 16.w),
          
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: state.user.name,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                SizedBox(height: 4.h),
                CommonText(
                  text: state.user.email,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subTitle,
                ),
              ],
            ),
          ),
          
          // Edit Profile Button
          CommonButton(
            titleText: AppStrings.editProfile,
            buttonHeight: 36,
            buttonWidth: 100,
            titleSize: 12,
            onTap: () {
              ref.read(personalInfoNotifierProvider.notifier).toggleEditing();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(PersonalInfoState state) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CommonText(
        text: state.about,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.subTitle,
        maxLines: 10,
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildFormFields(PersonalInfoState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name Field
        _buildFieldLabel(AppStrings.fullName),
        SizedBox(height: 8.h),
        CommonTextField(
          controller: _fullNameController,
          hintText: AppStrings.fullName,
          borderColor: AppColors.filledColor,
          fillColor: AppColors.white,
          borderRadius: 8,
          onChanged: (value) {
            ref.read(personalInfoNotifierProvider.notifier).updateFullName(value);
          },
        ),
        SizedBox(height: 20.h),
        
        // Email Field
        _buildFieldLabel(AppStrings.email),
        SizedBox(height: 8.h),
        CommonTextField(
          controller: _emailController,
          hintText: AppStrings.email,
          borderColor: AppColors.filledColor,
          fillColor: AppColors.white,
          borderRadius: 8,
          onChanged: (value) {
            ref.read(personalInfoNotifierProvider.notifier).updateEmail(value);
          },
        ),
        SizedBox(height: 20.h),
        
        // Address Field
        _buildFieldLabel(AppStrings.address),
        SizedBox(height: 8.h),
        CommonTextField(
          controller: _addressController,
          hintText: AppStrings.address,
          borderColor: AppColors.filledColor,
          fillColor: AppColors.white,
          borderRadius: 8,
          onChanged: (value) {
            ref.read(personalInfoNotifierProvider.notifier).updateAddress(value);
          },
        ),
        
        // Action Buttons (when editing)
        if (state.isEditing) ...[
          SizedBox(height: 32.h),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  titleText: AppStrings.cancel,
                  buttonHeight: 50,
                  buttonColor: AppColors.transparent,
                  titleColor: AppColors.black,
                  borderColor: AppColors.filledColor,
                  borderWidth: 1,
                  onTap: () {
                    ref.read(personalInfoNotifierProvider.notifier).cancelEditing();
                    _resetControllers(state);
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CommonButton(
                  titleText: 'Save',
                  buttonHeight: 50,
                  isLoading: state.isLoading,
                  onTap: () {
                    ref.read(personalInfoNotifierProvider.notifier).saveProfile();
                  },
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    return CommonText(
      text: label,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    );
  }

  void _resetControllers(PersonalInfoState state) {
    _fullNameController.text = state.user.name;
    _emailController.text = state.user.email;
    _addressController.text = state.address;
  }
}
