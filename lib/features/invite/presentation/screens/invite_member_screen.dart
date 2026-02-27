import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/component/text_field/common_text_field.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/core/utils/extensions/extension.dart';
import 'package:stays_hotel_booking/features/invite/presentation/providers/invite_member_provider.dart';

class InviteMemberScreen extends ConsumerStatefulWidget {
  const InviteMemberScreen({super.key});

  @override
  ConsumerState<InviteMemberScreen> createState() => _InviteMemberScreenState();
}

class _InviteMemberScreenState extends ConsumerState<InviteMemberScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inviteMemberNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.bg
      ,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: AppColors.bg
          ,
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
              
              // Header
              _buildHeader(),
              
              SizedBox(height: 32.h),
              
              // Invite via email section
              _buildEmailSection(state),
              
              SizedBox(height: 32.h),
              
              // Invite via link section
              _buildLinkSection(state),
              
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
            text: AppStrings.inviteMember,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.text
          ),
        ),
      ],
    );
  }

  Widget _buildEmailSection(InviteMemberState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        const CommonText(
          text: AppStrings.inviteViaEmail,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.text,
        ),
        SizedBox(height: 16.h),
        
        // Email input field
        CommonTextField(
          controller: _emailController,
          hintText: AppStrings.emailAddress,
          keyboardType: TextInputType.emailAddress,
          borderColor: AppColors.black,
          hintTextColor: AppColors.subTitle,
          fillColor: AppColors.overlayBox,
          borderRadius: 8,
          onChanged: (value) {
            ref.read(inviteMemberNotifierProvider.notifier).updateEmail(value);
            if (state.error != null) {
              ref.read(inviteMemberNotifierProvider.notifier).clearError();
            }
          },
        ),
        SizedBox(height: 44.h),
        
        // Send invite button
        CommonButton(
          titleText: AppStrings.sendInvite,
          buttonHeight: 50,
          isLoading: state.isLoading,
          onTap: () {
            ref.read(inviteMemberNotifierProvider.notifier).sendEmailInvite();
          },
        ),
        
      ],
    );
  }

  Widget _buildLinkSection(InviteMemberState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        20.height,
        // Section title
        const CommonText(
          text: AppStrings.inviteViaLink,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.text,
        ),
        SizedBox(height: 16.h),
        
        // Link field with copy button
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.overlayBox,
            borderRadius: BorderRadius.circular(8.r),
            //border: Border.all(color: AppColors.filledColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: CommonText(
                  text: state.inviteLink,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subTitle,
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () {
                  ref.read(inviteMemberNotifierProvider.notifier).copyInviteLink();
                },
                child: const Icon(
                  Icons.copy,
                  color: AppColors.subTitle,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
        
     
      ],
    );
  }
}
